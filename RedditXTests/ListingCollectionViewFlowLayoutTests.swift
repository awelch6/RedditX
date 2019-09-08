//
//  ListingCollectionViewFlowLayoutTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class ListingCollectionViewFlowLayoutTests: QuickSpec {
    override func spec() {
        
        var layout: ListingCollectionViewFlowLayout!
        
        beforeEach {
            layout = ListingCollectionViewFlowLayout()
        }
        
        it("should set the correct minimumInteritemSpacing") {
            expect(layout.minimumInteritemSpacing).to(equal(12))
        }
        
        it("should set the correct estimatedSize") {
            expect(layout.estimatedItemSize).to(equal(CGSize(width: 40, height: 30)))
        }
        
        it("should set the correct scrollDirection") {
            expect(layout.scrollDirection).to(equal(.horizontal))
        }
    }
}
