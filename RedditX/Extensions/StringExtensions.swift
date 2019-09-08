//
//  StringExtensions.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation

extension String {
    
    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            preconditionFailure("Unable to create NSDataDetector!")
        }
        
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        }
        
        return false
    }
}
