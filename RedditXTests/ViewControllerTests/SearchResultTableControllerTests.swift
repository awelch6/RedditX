//
//  SearchResultTableControllerTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class SearchResultTableControllerTests: QuickSpec {
    
    override func spec() {
        
        var searchResultController: SearchResultTableController!
        let mockDelegate = MockSearchResultTableControllerDelegate()
        
        context("when a new SearchResultTableController is initialized") {
            
            beforeEach {
                searchResultController = SearchResultTableController()
            }
            
            it("should setup the tableView correctly") {
                
                _ = searchResultController.view //trigger the view lifecycle
                
                expect(searchResultController.tableView.rowHeight).to(equal(65))
                expect(searchResultController.tableView.estimatedRowHeight).to(equal(100))
                expect(searchResultController.tableView.showsVerticalScrollIndicator).to(beTrue())
                expect(searchResultController.tableView.alwaysBounceVertical).to(beTrue())
                expect(searchResultController.tableView.keyboardDismissMode).to(equal(.onDrag))
            }
            
            it("should only add imageDownloaders to the imageCache if they have a valid URL") {
                let validPost = MockObjects.subreddit(iconURL: "www.validURL.com")
                let invalidPost = MockObjects.subreddit()
                
                searchResultController.subreddits = [validPost, invalidPost, validPost]
                
                expect(searchResultController.imageCache.keys.count).to(equal(2))
            }
        }
        
        describe("UITableViewDelegate & UITableViewDatasource") {
            let displayName = "r/Aww"
            let subscribers = 1_000_000
            
            let subreddit = MockObjects.subreddit(displayName: displayName, subscribers: subscribers)
            
            beforeEach {
                searchResultController = SearchResultTableController()
                searchResultController.delegate = mockDelegate
            }
            
            it("should display the correct view model for each cell") {
                let indexPath = IndexPath(row: 0, section: 0)
                
                searchResultController.subreddits = [subreddit, subreddit]
                _ = searchResultController.tableView(searchResultController.tableView, cellForRowAt: indexPath)
                
                let cell = searchResultController.tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell
                
                expect(cell?.textLabel).notTo(beNil())
            }
            
            it("should call didSelectSubreddit when a searchResultTableViewCell is selected") {
                let indexPath = IndexPath(row: 0, section: 0)
                
                searchResultController.subreddits = [subreddit, subreddit]
                searchResultController.tableView(searchResultController.tableView, didSelectRowAt: indexPath)
                
                expect(mockDelegate.didSelectSubredditWasCalled).to(equal(1))
            }
        }
        
        describe("ImageDownloaderDelegate") {
            let displayName = "r/Aww"
            let subscribers = 1_000_000
            
            let subreddit = MockObjects.subreddit(displayName: displayName, subscribers: subscribers)
            
            let mockTableview = MockTableView()
            
            beforeEach {
                searchResultController = SearchResultTableController()
                searchResultController.delegate = mockDelegate
            }
            
            it("should reload tableView cells anytime an images gets downloaded") {
                searchResultController.tableView = mockTableview
                let imageDownloader = ImageDownloader(position: 0, url: URL(string: "www.google.com")!, delegate: searchResultController)
                    
                searchResultController.subreddits = [subreddit, subreddit]
                searchResultController.imageDownloader(imageDownloader, downloaded: UIImage(named: "reddit")!, at: 0)
                
                expect(mockTableview.reloadRowsWasCalledTimes).to(equal(1))
                expect(mockTableview.reloadRowsWasCalledWith?.animation).to(equal(.automatic))
                expect(mockTableview.reloadRowsWasCalledWith?.indexPaths).to(contain([IndexPath(row: 0, section: 0)]))
            }
        }
    }
}
