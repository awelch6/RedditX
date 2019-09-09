//
//  MockListingCollectionViewDelegate.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

@testable import RedditX

class MockListingCollectionViewDelegate: ListingCollectionViewDelegate {
    var didSelectWasCalledTimes = 0
    var didSelectWasCalledWith: (collectionView: ListingsCollectionView, listingType: ListingType)?
    
    func collectionView(_ collectionView: ListingsCollectionView, didSelect listingType: ListingType) {
        didSelectWasCalledTimes += 1
        didSelectWasCalledWith = (collectionView, listingType)
    }
}

extension MockListingCollectionViewDelegate: TestResetable {
    func resetCounters() {
        didSelectWasCalledTimes = 0
    }
    
    func resetParameters() {
        didSelectWasCalledWith = nil
    }
}
