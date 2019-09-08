//
//  MockObjects.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation

@testable import RedditX

struct MockObjects {
    
    static func post(author: String? = nil, name: String? = nil, subreddit: String? = nil, thumbnail: String? = nil, url: String? = nil, title: String? = nil, created: Int? = nil, downs: Int = 1, numComments: Int = 1, score: Int = 1, ups: Int = 1, preview: Preview? = nil) -> Content<Post> {
        
        let post = Post(author: author, name: name, subreddit: subreddit, thumbnail: thumbnail,
                        url: url, title: title, created: created, downs: downs,
                        numComments: numComments, score: score, ups: ups, preview: preview)
        
        return Content(kind: "t4", data: post)
    }
    
    static func subreddit(displayName: String = "awww", name: String = "asd21", created: Int = 1, subscribers: Int = 1, iconURL: String? = nil, url: String? = nil, id: String? = nil) -> Content<Subreddit> {
        
        let subreddit = Subreddit(displayName: displayName, name: name, created: created, subscribers: subscribers, iconURL: iconURL, url: url, id: id)
        
        return Content(kind: "t5", data: subreddit)
    }
}
