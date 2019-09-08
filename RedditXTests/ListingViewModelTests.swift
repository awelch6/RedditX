//
//  ListingViewModelTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class ListingViewModelTests: QuickSpec {
    override func spec() {
        
        let listingTypes = ListingType.allCases
        
        it("should have the correct title for each listing type") {
            
            let expectedTitles = ["Popular", "Best", "Random", "Rising"]
            
            for (index, listingType) in listingTypes.enumerated() {
                let viewModel = ListingViewModel(listingType: listingType)
                expect(viewModel.title).to(equal(expectedTitles[index]))
            }
        }
    }
}
