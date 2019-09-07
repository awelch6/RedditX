//
//  IntExtensions.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation

extension Int {
    
    func toHumanReadableTime() -> String? {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "h:mm aa"
        return dateFormatter.string(from: date)
    }
}
