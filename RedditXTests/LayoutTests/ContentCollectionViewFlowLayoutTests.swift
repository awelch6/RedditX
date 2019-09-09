//
//  ContentCollectionViewFlowLayoutTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import RedditX

class ContentCollectionViewFlowLayoutTests: QuickSpec {
    override func spec() {
        
        var layout: ContentCollectionViewFlowLayout!
        
        beforeEach {
            layout = ContentCollectionViewFlowLayout()
        }
        
        it("should set the correct sectionInsets") {
            expect(layout.sectionInset).to(equal(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)))
        }
        
        it("should set the correct estimatedSize") {
            let screenSize = UIScreen.main.bounds
            
            expect(layout.estimatedItemSize).to(equal(CGSize(width: screenSize.width - 20, height: 300)))
        }
        
        it("should set the correct scrollDirection") {
            expect(layout.scrollDirection).to(equal(.vertical))
        }
    }
}
