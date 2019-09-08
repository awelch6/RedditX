//
//  MockNetworkable.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import NetworkX

typealias RedditResponse = ([Content<Post>], NetworkError?) -> Void
typealias RedditSearchResponse = ([Content<Subreddit>], NetworkError?) -> Void

protocol Netoworkable {
    var baseURL: String { get set }
    var requestManager: Requestable { get set }
    
    func request(subreddit: String, limit: Int, after: String?, _ completion: @escaping RedditResponse)
    
    func search(query: String, _ completion: @escaping RedditSearchResponse)
}

extension Netoworkable {
    func request(subreddit: String, limit: Int = 10, after: String? = nil, _ completion: @escaping RedditResponse) { }
}
