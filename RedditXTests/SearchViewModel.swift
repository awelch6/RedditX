//
//  SearchViewModel.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class SearchViewModelTests: QuickSpec {
    override func spec() {
        
        context("when accessing the 'title' property") {
            
            it("should return the post's title if one exists") {
                let title = "Hello World"
                let post = MockObjects.post(title: title)
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.title).to(equal(title))
            }
            
            it("should return nil if a title does not exist") {
                let post = MockObjects.post()
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.title).to(beNil())
            }
        }
        
        context("when accessing the 'thumbnailURL' property") {
            
            it("should return the correct thumbnailURL if one exists") {
                let source = Source(url: "www.validURL.com", width: 10, height: 10)
                let image = Image(source: source, resolutions: [], id: "123")
                let preview = Preview(images: [image], enabled: true)
                
                let post = MockObjects.post(preview: preview)
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.thumbnailURL).notTo(beNil())
            }
            
            it("should return nil if there is no thumbnail") {
                let post = MockObjects.post()
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.thumbnailURL).to(beNil())
            }
            
            it("should return nil if the thumbnail is an invalid url") {
                let source = Source(url: "http://en.\n\n\n\n\n\nwikipedia.org/wiki/---)", width: 10, height: 10)
                let image = Image(source: source, resolutions: [], id: "123")
                let preview = Preview(images: [image], enabled: true)
                
                let post = MockObjects.post(preview: preview)
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.thumbnailURL).to(beNil())
            }
        }
        
        context("when accessing the 'authorName' property") {
            
            it("should return an attributed string with the author's name") {
                let authorName = "Author"
                let post = MockObjects.post(author: authorName)
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.authorName.string).to(equal("u/\(authorName)\n"))
            }
            
            it("should append on a human readable time stamp if one exists") {
                let authorName = "Author"
                let timestamp = 1_567_983_708
                let post = MockObjects.post(author: authorName, created: timestamp)
                
                let viewModel = ContentViewModel(post: post.data)
                
                expect(viewModel.authorName.string).to(equal("u/\(authorName)\n11:01 PM"))
                
            }
        }
        
        context("when setting an image") {
            
            it("should set the 'image' property") {
                var viewModel = ContentViewModel(post: MockObjects.post().data)
                
                let image = UIImage(named: "reddit")
                viewModel.setImage(image)
                
                expect(viewModel.image).to(equal(image))
                
                viewModel.setImage(nil)
                
                expect(viewModel.image).to(beNil())
            }
        }
    }
}
