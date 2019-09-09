//
//  ContentCollectionControllerTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class ContentCollectionControllerTests: QuickSpec {
    
    override func spec() {
        
        var contentViewController: ContentCollectionController!
        let mockDelegate = MockContentCollectionControllerDelegate()
        
        let source = Source(url: "www.validURL.com", width: 10, height: 10)
        let image = Image(source: source, resolutions: [], id: "123")
        let preview = Preview(images: [image], enabled: true)
        
        context("when a new ContentCollectionController is initialized") {
            
            beforeEach {
                contentViewController = ContentCollectionController(collectionViewLayout: ContentCollectionViewFlowLayout())
                contentViewController.delegate = mockDelegate
            }
            
            it("should setup the collectionview correctly") {
                
                _ = contentViewController.view //trigger the view lifecycle
                
                expect(contentViewController.collectionView.refreshControl).notTo(beNil())
                expect(contentViewController.collectionView.backgroundColor).to(equal(Colors.whiteX))
                expect(contentViewController.collectionView.keyboardDismissMode).to(equal(.onDrag))
            }
            
            it("should setup the refreshControl properly") {
                _ = contentViewController.view //trigger the view lifecycle
                
                expect(contentViewController.refreshControl.tintColor).to(equal(Colors.greenX))
                expect(contentViewController.refreshControl.attributedTitle?.string).to(equal("Fetching More Content..."))
                expect(contentViewController.refreshControl.layer.zPosition).to(equal(-1))
            }
        }
        
        context("when the collectionView is pulled to refresh") {
            
            beforeEach {
                contentViewController = ContentCollectionController(collectionViewLayout: ContentCollectionViewFlowLayout())
                contentViewController.delegate = mockDelegate
            }
            
            it("should call didPullToRefresh") {
                contentViewController.refreshAction(UIRefreshControl())
                
                expect(mockDelegate.didPullToRefreshWasCalledTimes).to(equal(1))
            }
        }
        
        context("when add(_:_:) is called") {
            
            it("should clear existing imageCache if add(_:_:) is called with true for 'clearExisting'") {
                let validPost = MockObjects.post(preview: preview)
                
                contentViewController.add(posts: [validPost, validPost, validPost], clearExisting: true)
                
                expect(contentViewController.imageCache.keys.count).to(equal(3))
            }
            
            it("should append new posts to the existing imageCache if add(_:_:) is called with false for 'clearExisting'") {
                let validPost = MockObjects.post(preview: preview)
                
                contentViewController.add(posts: [validPost, validPost, validPost], clearExisting: true) //simulate images already existing in cache
                
                contentViewController.add(posts: [validPost, validPost, validPost], clearExisting: false)
                
                expect(contentViewController.imageCache.keys.count).to(equal(6))
            }
            
            it("should only add imageDownloaders to the imageCache if they have a valid URL") {
               
                let validPost = MockObjects.post(preview: preview)
                let invalidPost = MockObjects.post()
                
                contentViewController.add(posts: [validPost, invalidPost, validPost], clearExisting: true)
                
                expect(contentViewController.imageCache.keys.count).to(equal(2))
            }
        }

        describe("UICollectionViewDelegate & UICollectionViewDatasource") {
            let post = MockObjects.post(title: "title")
            var navigationController: UINavigationController!

            beforeEach {
                contentViewController = ContentCollectionController(collectionViewLayout: ContentCollectionViewFlowLayout())
                navigationController = UINavigationController(rootViewController: contentViewController)
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = navigationController
                
                _ = contentViewController.view
                contentViewController.delegate = mockDelegate
                mockDelegate.resetAll()
            }

            it("should display the correct view model for each cell") {
                let indexPath = IndexPath(item: 0, section: 0)

                contentViewController.add(posts: [post, post], clearExisting: true)

                let cell = contentViewController.collectionView(contentViewController.collectionView, cellForItemAt: indexPath) as? ContentCollectionViewCell
                
                cell?.display(viewModel: ContentViewModel(post: contentViewController.posts[indexPath.item].data))
                
                expect(cell?.postDetailsView.titleLabel.text).notTo(beNil())
            }
            
            it("should call shouldLoadMore if the collectionView is about to reach the end") {
                let validPost = MockObjects.post(preview: preview)
                
                contentViewController.add(posts: [validPost, validPost, validPost], clearExisting: true)
                
                contentViewController.collectionView(contentViewController.collectionView, willDisplay: UICollectionViewCell(), forItemAt: IndexPath(item: 2, section: 0))
                
                expect(mockDelegate.shouldLoadMoreWasCalledTimes).to(equal(1))
            }

            it("should call push a webView controller onto the stack when a cell is selected") {
                let validPost = MockObjects.post(preview: preview)
                
                contentViewController.add(posts: [validPost, validPost, validPost], clearExisting: true)
                
                contentViewController.collectionView(contentViewController.collectionView, didSelectItemAt: IndexPath(item: 2, section: 0))
                
                expect(navigationController.viewControllers.contains(where: { $0 is WebViewController })).toEventually(beTrue())
            }
        }
    }
}
