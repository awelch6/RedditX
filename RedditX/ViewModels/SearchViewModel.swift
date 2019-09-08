//
//  SearchViewModel.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

struct SearchViewModel {
    
    var attributedText: NSMutableAttributedString {
        var titleAttributes = NSMutableAttributedString()
        
        titleAttributes = NSMutableAttributedString(string: subreddit.displayName + "\n",
                                                    attributes: [.font: Fonts.bold(16), .foregroundColor: Colors.blackX])
        
        if let subscriberCount = formattedSubscriberCount {
            let string = "Community • \(subscriberCount) members"
            let attributes = NSMutableAttributedString(string: string,
                                                       attributes: [.font: Fonts.regular(12), .foregroundColor: Colors.grayX])
            titleAttributes.append(attributes)
        }
        
        return titleAttributes
        
    }
    
    var formattedSubscriberCount: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: subreddit.subscribers))
    }
    
    private(set) var icon: UIImage?
    
    private let subreddit: Subreddit
    
    init(subreddit: Subreddit) {
        self.subreddit = subreddit
    }
    
    mutating func setImage(_ image: UIImage?) {
        self.icon = image
    }
}
