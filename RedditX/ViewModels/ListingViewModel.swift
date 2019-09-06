//
//  ListingViewModel.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

struct ListingViewModel {
    
    var title: String {
        return listingType.rawValue.capitalized
    }
    
    private let listingType: ListingType
    
    init(listingType: ListingType) {
        self.listingType = listingType
    }
}
