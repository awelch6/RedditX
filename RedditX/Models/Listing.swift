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
    let children: [Child]
}

// MARK: - Child
struct Child: Decodable {
    let kind: String
    let data: DataElement
}

// MARK: - DataClass

struct DataElement: Decodable {
    
    let author, name, subreddit, url: String?
    let permalink, title: String?
    let created, downs, numComments, score, ups: Int?
    let preview: Preview?

    enum CodingKeys: String, CodingKey {
        case created, downs, name, permalink, score, subreddit, title, preview, ups, url
        case author = "author_fullname"
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
