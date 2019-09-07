//
//  File.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation

// MARK: - Listing
struct Listing: Decodable {
    let kind: String
    let data: ListingData
}

// MARK: - ListingData
struct ListingData: Decodable {
    let content: [Content]
    
    enum CodingKeys: String, CodingKey {
        case content = "children"
    }
}

// MARK: - Child
struct Content: Decodable {
    let kind: String
    let post: Post
    
    enum CodingKeys: String, CodingKey {
        case kind
        case post = "data"
    }
}

// MARK: - DataClass

struct Post: Decodable {
    
    let author, name, subreddit, thumbnail, url: String?
    let permalink, title: String?
    let created, downs, numComments, score, ups: Int?
    let preview: Preview?

    enum CodingKeys: String, CodingKey {
        case author, created, downs, name, permalink, score, subreddit, thumbnail, title, preview, ups, url
        case numComments = "num_comments"
    }
}

// MARK: - Preview

struct Preview: Decodable {
    let images: [Image]
    let enabled: Bool
}

// MARK: - Image

struct Image: Decodable {
    let source: Source
    let resolutions: [Source]
    let id: String
}

// MARK: - Source

struct Source: Decodable {
    let url: String
    let width: Int
    let height: Int
}
