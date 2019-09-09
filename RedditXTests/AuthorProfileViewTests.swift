//
//  AuthorProfileViewTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class AuthorProfileViewTests: QuickSpec {
    
    override func spec() {
        
        var authorProfileView: AuthorProfileView!
        
        context("when a new AuthorProfileView is initialized") {
            
            beforeEach {
                authorProfileView = AuthorProfileView()
            }
            
            it("should set the correct properties") {
                expect(authorProfileView.backgroundColor).to(equal(Colors.whiteX))
                expect(authorProfileView.translatesAutoresizingMaskIntoConstraints).to(equal(false))
            }
            
            it("should setup the thumbnail imageView correctly") {
                expect(authorProfileView.subviews.contains(where: { $0 is UIImageView })).to(beTrue())
            }
            
            it("should setup the correct authorDetailsLabel") {
                expect(authorProfileView.subviews.contains(where: { $0 is UILabel })).to(beTrue())
                
                expect(authorProfileView.authorDetailsLabel.numberOfLines).to(equal(2))
                expect(authorProfileView.authorDetailsLabel.textAlignment).to(equal(.left))
            }
        }
        
        context("when the view life cycle starts") {
            beforeEach {
                authorProfileView = AuthorProfileView()
                authorProfileView.layoutSubviews()
            }
            
            it("should add a corner mask to the view") {
                expect(authorProfileView.layer.mask).notTo(beNil())
            }
            
            it("should have the correct intrinsic content size") {
                expect(authorProfileView.intrinsicContentSize).to(equal(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 65)))
            }
        }
    }
}
