//
//  SearchViewModel.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class SearchViewModelTests: QuickSpec {
    override func spec() {
        
        context("when accessing the 'attributedText' property") {
            
            it("should return an attributed string with the subreddit's display name and number of subscribers") {
                let displayName = "r/aww"
                let subscribers: Int = 1_000_000
                let subreddit = MockObjects.subreddit(displayName: displayName, subscribers: subscribers)
                
                let viewModel = SearchViewModel(subreddit: subreddit.data)
                
                let expectedString = "\(displayName)\nCommunity • 1,000,000 members"
                expect(viewModel.attributedText.string).to(equal(expectedString))
            }
        }
        
        context("when setting an image") {
            
            it("should set the 'image' property") {
                var viewModel = SearchViewModel(subreddit: MockObjects.subreddit().data)
                
                let image = UIImage(named: "reddit")
                viewModel.setImage(image)
                
                expect(viewModel.icon).to(equal(image))
                
                viewModel.setImage(nil)
                
                expect(viewModel.icon).to(beNil())
            }
        }
    }
}
