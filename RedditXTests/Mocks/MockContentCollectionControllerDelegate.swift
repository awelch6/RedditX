//
//  MockContentCollectionControllerDelegate.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

@testable import RedditX

class MockContentCollectionControllerDelegate: ContentCollectionControllerDelegate {
    var didPullToRefreshWasCalledTimes = 0
    var shouldLoadMoreWasCalledTimes = 0
    var shouldLoadMoreWasCalledWith: String?
    
    func collectionView(_ collectionView: ContentCollectionController, didPullToRefresh: Bool) {
        didPullToRefreshWasCalledTimes += 1
    }
    
    func collectionView(_ collectionView: ContentCollectionController, shouldLoadMore after: String?) {
        shouldLoadMoreWasCalledTimes += 1
        shouldLoadMoreWasCalledWith = after
    }
}

extension MockContentCollectionControllerDelegate: TestResetable {
    
    func resetCounters() {
        didPullToRefreshWasCalledTimes = 0
        shouldLoadMoreWasCalledTimes = 0
    }
    
    func resetParameters() {
        shouldLoadMoreWasCalledWith = nil
    }
}
