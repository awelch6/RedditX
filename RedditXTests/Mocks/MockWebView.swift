//
//  MockWebView.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import WebKit

class MockWebView: WKWebView {
    
    var loadWasCalledTimes = 0
    var loadWasCalledWith: URLRequest?
    
    override func load(_ request: URLRequest) -> WKNavigation? {
        loadWasCalledTimes += 1
        loadWasCalledWith = request
        return nil
    }
}

// MARK: TestResetable

extension MockWebView: TestResetable {
    
    func resetCounters() {
        loadWasCalledTimes = 0
    }
    
    func resetParameters() {
        loadWasCalledWith = nil
    }
}
