//
//  ListingType.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

enum ListingType: String {
    case best
    case controversial
    case hot
    case new
    case random
    case rising
    case top
}

// MARK: Case Iterable

extension ListingType: CaseIterable { }
