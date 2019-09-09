//
//  ListingCollectionViewTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class ListingCollectionViewTests: QuickSpec {
    override func spec() {
        
        var listingCollectionView: ListingsCollectionView!
        
        context("when a new listingsCollectionView is initialized") {
            
            beforeEach {
                listingCollectionView = ListingsCollectionView()
            }
            
            it("should conform to UITableViewDatasource and UITableViewDelegate") {
                expect(listingCollectionView.delegate).notTo(beNil())
                expect(listingCollectionView.delegate).notTo(beNil())
            }
            
            it("should set the correct properties") {
                expect(listingCollectionView.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                expect(listingCollectionView.backgroundColor).to(equal(Colors.whiteX))
                expect(listingCollectionView.showsHorizontalScrollIndicator).to(beFalse())
                expect(listingCollectionView.alwaysBounceHorizontal).to(beTrue())
            }
        }
        
        describe("UICollectionViewDelegate & UICollectionViewDatasource & UICollectionViewDelegateFlowLayout") {
            let mockDelegate = MockListingCollectionViewDelegate()
            
            beforeEach {
                listingCollectionView = ListingsCollectionView()
                listingCollectionView.listingDelegate = mockDelegate
                
                mockDelegate.resetAll()
            }
            
            it("should have the correct number of items and sectionds") {
                expect(listingCollectionView.numberOfSections).to(equal(1))
                expect(listingCollectionView.numberOfItems(inSection: 0)).to(equal(4))
            }
            
            it("should display the cell correctly") {
               let cell = listingCollectionView.collectionView(listingCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? ListingCollectionViewCell
                
                expect(cell?.title.text).to(equal("Popular"))
            }
            
            it("should set the selectedListing if a cell gets selected") {
                listingCollectionView.collectionView(listingCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                
                expect(listingCollectionView.selectedListing).to(equal(IndexPath(item: 0, section: 0)))
                expect(mockDelegate.didSelectWasCalledTimes).to(equal(1))
                expect(mockDelegate.didSelectWasCalledWith?.listingType).to(equal(.popular))
            }
            
            it("should return the correct layout insets") {
                let expectedInsets = UIEdgeInsets(top: 0.0, left: -208.0, bottom: 0.0, right: -208.0)
                
                let insets = listingCollectionView.collectionView(listingCollectionView, layout: listingCollectionView.flowLayout, insetForSectionAt: 0)
               
                expect(insets).to(equal(expectedInsets))
            }
        }
    }
}
