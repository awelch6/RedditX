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
    
    func request(subreddit: String, _ completion: @escaping RedditResponse)
    
    func search(query: String, _ completion: @escaping RedditSearchResponse)
}

typealias RedditResponse = ([Content<Post>], NetworkError?) -> Void
typealias RedditSearchResponse = ([Content<Subreddit>], NetworkError?) -> Void

struct Networker: Netoworkable {
    
    var baseURL: String = "https://api.reddit.com"
    
    var requestManager: Requestable
    
    init(requestManager: Requestable = RequestManager(encoder: URLParameterEncoder())) {
        self.requestManager = requestManager
    }
    
    func request(listing: ListingType, _ completion: @escaping RedditResponse) {
        guard let url = URL(string: "\(baseURL)/r/\(listing.rawValue.lowercased()).json") else {
            return completion([], .invalidURL)
        }
        
        requestManager.request(type: Listing<Post>.self, url: url, method: .get, parameters: nil, headers: nil) { (response) in
            switch response {
            case .success(let model):
                completion(model.content, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func request(subreddit: String, _ completion: @escaping RedditResponse) {
        guard let url = URL(string: "\(baseURL)\(subreddit).json") else {
            return completion([], .invalidURL)
        }
        
        requestManager.request(type: Listing<Post>.self, url: url, method: .get, parameters: nil, headers: nil) { (response) in
            switch response {
            case .success(let model):
                completion(model.content, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
    
    func search(query: String, _ completion: @escaping RedditSearchResponse) {
        
        guard let url = URL(string: "\(baseURL)/subreddits/search.json") else {
            return completion([], .invalidURL)
        }
        
        let parameters: Parameters = [
            "q": query,
            "sort": "top"
        ]
        
        requestManager.request(type: Listing<Subreddit>.self, url: url, method: .get, parameters: parameters, headers: nil) { (response) in
            
            switch response {
            case .success(let model):
                completion(model.content, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
