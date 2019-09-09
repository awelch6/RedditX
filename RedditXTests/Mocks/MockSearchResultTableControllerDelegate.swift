//
//  MockSearchResultTableControllerDelegate.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

@testable import RedditX

class MockSearchResultTableControllerDelegate: SearchResultTableControllerDelegate {
    
    var didSelectSubredditWasCalled = 0
    var didSelectSubredditCalledWith: Subreddit?
    
    func searchResult(_ searchResultTableController: SearchResultTableController, didSelect subreddit: Subreddit) {
        didSelectSubredditWasCalled += 1
        didSelectSubredditCalledWith = subreddit
    }
}

extension MockSearchResultTableControllerDelegate: TestResetable {
    
    func resetCounters() {
        didSelectSubredditWasCalled = 0
    }
    
    func resetParameters() {
        didSelectSubredditCalledWith = nil
    }
}
