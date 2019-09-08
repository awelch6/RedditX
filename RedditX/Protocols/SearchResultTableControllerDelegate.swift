//
//  SearchResultTableControllerDelegate.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

protocol SearchResultTableControllerDelegate: class {
    func searchResult(_ searchResultTableController: SearchResultTableController, didSelect subreddit: Subreddit)
}
