//
//  StringExtensionsTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class StringExtensionsTests: QuickSpec {
    override func spec() {
     
        it("should return true for a valid URL string") {
            let validURLs = ["http://www.google.com", "https://www.fs.blog/2017/02/naval-ravikant-reading-decision-making/", "www.google.com"]
            
            validURLs.forEach {
                expect($0.isValidURL).to(beTrue())
            }
        }
        
        it("should return false for an invalid URL string") {
            let invalidURLs = ["", "self", "www. google.com"]
            
            invalidURLs.forEach {
                expect($0.isValidURL).to(beFalse())
            }
        }
    }
}
