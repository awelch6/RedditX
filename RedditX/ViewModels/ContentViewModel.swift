//
//  ContentViewModel.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

struct ContentViewModel {
    
    var title: String {
        return content.post.title ?? ""
    }
    
    var thumbnailURL: URL? {
        guard let thumbnail = content.post.preview?.images.first?.source.url, thumbnail != "self" else {
            return nil
        }
        return URL(string: thumbnail)
    }
    
    var thumbnailSize: CGSize? {
        guard let source = content.post.preview?.images.first?.source else {
            return nil
        }
        
        return CGSize(width: source.width, height: source.height)
    }
    
    var authorName: NSMutableAttributedString {
        var titleAttributes = NSMutableAttributedString()
        
        if let name = content.post.author {
            titleAttributes = NSMutableAttributedString(string: "u/\(name)" + "\n",
                                                        attributes: [.font: Fonts.bold(16), .foregroundColor: Colors.blackX])
        }
        
        if let time = content.post.created?.toHumanReadableTime() {
            let attributes = NSMutableAttributedString(string: time, attributes: [.font: Fonts.regular(12), .foregroundColor: Colors.grayX])
            titleAttributes.append(attributes)
        }
        
        return titleAttributes
    }
    
    private(set) public var image: UIImage?
    
    private let content: Content
    
    init(content: Content) {
        self.content = content
    }
    
    public mutating func setImage(_ image: UIImage?) {
        self.image = image
    }
}
