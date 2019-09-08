//
//  ContentViewModel.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

struct ContentViewModel {
    
    var title: String? {
        return post.title
    }
    
    var thumbnailURL: URL? {
        guard let thumbnail = post.preview?.images.first?.source.url, thumbnail.isValidURL else {
            return nil
        }
        return URL(string: thumbnail)
    }
    
    var authorName: NSMutableAttributedString {
        var titleAttributes = NSMutableAttributedString()
        
        if let name = post.author {
            titleAttributes = NSMutableAttributedString(string: "u/\(name)" + "\n",
                                                        attributes: [.font: Fonts.bold(16), .foregroundColor: Colors.blackX])
        }
        
        if let time = post.created?.toHumanReadableTime() {
            let attributes = NSMutableAttributedString(string: time, attributes: [.font: Fonts.regular(12), .foregroundColor: Colors.grayX])
            titleAttributes.append(attributes)
        }
        
        return titleAttributes
    }
    
    private(set) public var image: UIImage?
    
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    public mutating func setImage(_ image: UIImage?) {
        self.image = image
    }
}
