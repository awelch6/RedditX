//
//  File.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation

// MARK: Listing

struct Listing<T: Decodable>: Decodable {
    let kind: String
    let data: ListingData<T>
}

// MARK Utilities

extension Listing {
    
    /// Convience variable that returns the listings content of a given type 'T'
    var content: [Content<T>] {
        return data.content
    }
}

// MARK: ListingData

struct ListingData<T: Decodable>: Decodable {
    
    let content: [Content<T>]
    
    enum CodingKeys: String, CodingKey {
        case content = "children"
    }
}

// MARK: Content

struct Content<T: Decodable>: Decodable {
    let kind: String
    let data: T
}

// MARK: Subreddit

struct Subreddit: Decodable {
    let id, name, url: String
    let created, subscribers: Int
    let iconURL: String?

    enum CodingKeys: String, CodingKey {
        case id, url, subscribers, created 
        case iconURL = "community_icon"
        case name = "display_name_prefixed"
    }
}

// MARK: Post

struct Post: Decodable {
    
    let author, name, subreddit, thumbnail, url: String?
    let title: String?
    let created, downs, numComments, score, ups: Int?
    let preview: Preview?

    enum CodingKeys: String, CodingKey {
        case author, created, downs, name, score, subreddit, thumbnail, title, preview, ups, url
        case numComments = "num_comments"
    }
}

// MARK: Preview

struct Preview: Decodable {
    let images: [Image]
    let enabled: Bool
}

// MARK: Image

struct Image: Decodable {
    let source: Source
    let resolutions: [Source]
    let id: String
}

// MARK: Source

struct Source: Decodable {
    let url: String
    let width: Int
    let height: Int
}
