//
//  Networker.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import NetworkX

struct Networker: Netoworkable {
    
    var baseURL: String = "https://api.reddit.com"
    
    var requestManager: Requestable
    
    init(requestManager: Requestable = RequestManager(encoder: URLParameterEncoder())) {
        self.requestManager = requestManager
    }
    
    func request(subreddit: String, limit: Int = 10, after: String? = nil, _ completion: @escaping RedditResponse) {
        
        guard let url = URL(string: "\(baseURL)/r/\(subreddit).json") else {
            return completion([], .invalidURL)
        }
        
        var parameters: Parameters = ["limit": limit]
        
        if let after = after {
            parameters["after"] = after
        }
        
        requestManager.request(type: Listing<Post>.self, url: url, method: .get, parameters: parameters, headers: nil) { (response) in
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
