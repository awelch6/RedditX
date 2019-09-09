//
//  SearchResultTableViewCellTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class SearchResultTableViewCellTests: QuickSpec {
    override func spec() {
        
        let searchResultTableViewCell = SearchResultTableViewCell()
        
        let displayName = "r/Aww"
        let subscribers = 1_000_000
        let subreddit = MockObjects.subreddit(displayName: displayName, subscribers: subscribers)
        
        var viewModel = SearchViewModel(subreddit: subreddit.data)
        
        it("should set correct properties when being displayed") {
            viewModel.setImage(UIImage(named: "reddit"))
            
            searchResultTableViewCell.display(viewModel: viewModel)
            
            expect(searchResultTableViewCell.textLabel?.text).notTo(beNil())
            expect(searchResultTableViewCell.imageView?.image).notTo(beNil())
        }
    }
}
