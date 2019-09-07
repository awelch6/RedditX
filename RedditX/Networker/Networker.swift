//
//  Networker.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import NetworkX

protocol Netoworkable {
    var baseURL: String { get set }
    var requestManager: Requestable { get set }
    
    func request(listing: ListingType, _ completion: @escaping RedditResponse)
    
    func request(subreddit: Subreddit, _ completion: @escaping RedditResponse)
    
    func search(query: String, _ cometion: @escaping RedditSearchResponse)
}

typealias Subreddit = String
typealias RedditResponse = ([Content], NetworkError?) -> Void
typealias RedditSearchResponse = ([String]) -> Void

struct Networker: Netoworkable {
    
    var baseURL: String = "https://api.reddit.com"
    
    var requestManager: Requestable
    
    init(requestManager: Requestable = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func request(listing: ListingType, _ completion: @escaping RedditResponse) {
        guard let url = URL(string: "\(baseURL)/r/\(listing.rawValue.lowercased()).json") else {
            return completion([], .invalidURL)
        }
        
        requestManager.request(type: Listing.self, url: url, method: .get, parameters: nil, headers: nil) { (response) in
            switch response {
            case .success(let model):
                completion(model.data.content, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func request(subreddit: Subreddit, _ completion: @escaping RedditResponse) {
        guard let url = URL(string: "\(baseURL)/r/\(subreddit).json") else {
            return completion([], .invalidURL)
        }
        
        requestManager.request(type: Listing.self, url: url, method: .get, parameters: nil, headers: nil) { (response) in
            switch response {
            case .success(let model):
                completion(model.data.content, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func search(query: String, _ cometion: @escaping RedditSearchResponse) {
        
    }
}
