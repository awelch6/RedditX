//
//  ContentCollectionViewCellTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import RedditX

class ContentCollectionViewCellTests: QuickSpec {
    
    override func spec() {
        
        var contentCollectionViewCell: ContentCollectionViewCell!
        
        context("when a new ContentCollectionViewCell is initialized") {
            
            beforeEach {
                contentCollectionViewCell = ContentCollectionViewCell()
            }
            
            it("should set the correct properties") {
                expect(contentCollectionViewCell.contentView.backgroundColor).to(equal(Colors.lightGrayX))
                expect(contentCollectionViewCell.translatesAutoresizingMaskIntoConstraints).to(equal(false))
            }
            
            it("should setup the authorProfileView correctly") {
                expect(contentCollectionViewCell.contentView.subviews.contains(where: { $0 is AuthorProfileView })).to(beTrue())
            }
            
            it("should setup the correct postDEtailsView") {
                expect(contentCollectionViewCell.contentView.subviews.contains(where: { $0 is PostDetailsView })).to(beTrue())
            }
        }
        
        context("when the view life cycle starts") {
            beforeEach {
                contentCollectionViewCell = ContentCollectionViewCell()
                contentCollectionViewCell.layoutSubviews()
            }
            
            it("should add the correct shadow") {
                expect(contentCollectionViewCell.contentView.layer.shadowOffset).to(equal(CGSize(width: 0, height: 2)))
                expect(contentCollectionViewCell.contentView.layer.shadowColor).to(equal(Colors.shadowX.cgColor))
                expect(contentCollectionViewCell.contentView.layer.shadowOpacity).to(equal(0.2))
                expect(contentCollectionViewCell.contentView.layer.shadowRadius).to(equal(5))
            }
        }
        
        context("when display(_:) is called") {
            
            let post = MockObjects.post()
            let viewModel = ContentViewModel(post: post.data)
            let mockPostDetailsView = MockPostDetailsView()
            
            beforeEach {
                contentCollectionViewCell = ContentCollectionViewCell()
                contentCollectionViewCell.postDetailsView = mockPostDetailsView
                contentCollectionViewCell.display(viewModel: viewModel)
            }
            
            it("should set the view up correctly") {
                
                expect(contentCollectionViewCell.authorProfileView.thumbnail.image).notTo(beNil())
                expect(contentCollectionViewCell.authorProfileView.authorDetailsLabel.attributedText).notTo(beNil())
                expect(mockPostDetailsView.displayWasCalledTimes).to(equal(1))
            }
            
            afterEach {
                mockPostDetailsView.resetCounters()
            }
        }
    }
}
