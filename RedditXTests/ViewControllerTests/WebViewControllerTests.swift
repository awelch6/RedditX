//
//  WebViewControllerTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble
import WebKit

@testable import RedditX

class WebViewControllerTests: QuickSpec {
    
    override func spec() {
        var webViewController: WebViewController!
        let post = MockObjects.post(url: "www.google.com").data
        var mockWebView: MockWebView!
    
        beforeEach {
            mockWebView = MockWebView()
            webViewController = WebViewController(webView: mockWebView, post: post)
        }
        
        it("should add a webview to the parent view") {
            expect(webViewController.view.subviews.contains(where: { $0 is WKWebView })).to(beTrue())
        }

        it("should load the post's url if it exists") {
            _ = webViewController.view //trigger lifecycle methods
            
            expect(mockWebView.loadWasCalledTimes).to(equal(1))
        }
        
        it("should do nothing if the url does not exist") {
            let post = MockObjects.post(url: nil)
            
            webViewController = WebViewController(webView: mockWebView, post: post.data)
            _ = webViewController.view //trigger lifecycle methods
            
            expect(mockWebView.loadWasCalledTimes).to(equal(0))
        }
    }
}
