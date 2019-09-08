//
//  NetworkerTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble
import NetworkX

@testable import RedditX

class NetworkerTests: QuickSpec {
    override func spec() {
        
        let listingPost = Listing(kind: "t4", data: ListingData<Post>(content: [MockObjects.post()]))
        let listingSubreddit = Listing(kind: "t4", data: ListingData<Subreddit>(content: [MockObjects.subreddit()]))
        
        var networker: Networker!
        var mockRequestable: MockRequestable!
        
        beforeEach {
            mockRequestable = MockRequestable(mode: MockRequestable.Mode.success(listingPost))
            networker = Networker(requestManager: mockRequestable)
        }
        
        context("when a new Networker is initialized") {
            
            it("should have the correct baseURL") {
                expect(networker.baseURL).to(equal("https://api.reddit.com"))
            }
            
            it("should have the correct encoder") {
                expect(mockRequestable.encoder).to(beAnInstanceOf(JSONParameterEncoder.self))
            }
        }
        
        context("when request(_:_:_:_:) is called") {
            
            beforeEach {
                mockRequestable = MockRequestable(mode: MockRequestable.Mode.success(listingPost))
                networker = Networker(requestManager: mockRequestable)
                mockRequestable.resetAll()
            }
            
            it("should return the completion handler with an .invalidURL error if there is an invalid URL") {
                networker.baseURL = "http://en.\n\n\n\n\n\nwikipedia.org/wiki/---)"
               
                waitUntil(action: { (done) in
                    networker.request(subreddit: "aww", { (posts, error) in
                        expect(posts.isEmpty).to(beTrue())
                        expect(error).to(equal(.invalidURL))
                        done()
                    })
                })
            }
            
            it("should add 'limit' parameter onto the request") {
                let limit = 5
                
                networker.request(subreddit: "aww", limit: limit, { _, _ in })
                
                expect(mockRequestable.requestWasCalledWith?.parameters?["limit"] as? Int).to(equal(limit))
                expect(mockRequestable.requestWasCalledWith?.parameters?["after"] as? String).to(beNil())
            }
            
            it("should add 'after' parameter onto the request if it exists") {
                let limit = 5
                let after = "123"
                
                networker.request(subreddit: "aww", limit: limit, after: after, { _, _ in })
                
                expect(mockRequestable.requestWasCalledWith?.parameters?["limit"] as? Int).to(equal(limit))
                expect(mockRequestable.requestWasCalledWith?.parameters?["after"] as? String).to(equal(after))

            }
            
            it("should complete with a list of Posts on success") {
                waitUntil(action: { (done) in
                    networker.request(subreddit: "aww", { posts, error in
                        expect(error).to(beNil())
                        expect(posts.isEmpty).to(beFalse())
                        done()
                    })
                })
            }
            
            it("should complete with an empty list of Posts on failure and an error") {
                mockRequestable = MockRequestable(mode: MockRequestable.Mode<Listing<Post>>.failed) as MockRequestable
                networker = Networker(requestManager: mockRequestable)
                
                mockRequestable.shouldFailWithError = .badRequest
                waitUntil(action: { (done) in
                    networker.request(subreddit: "aww", { posts, error in
                        expect(error).to(equal(.badRequest))
                        expect(posts.isEmpty).to(beTrue())
                        done()
                    })
                })
            }
        }
        
        context("when search(_:_:) is called") {
            
            beforeEach {
                mockRequestable = MockRequestable(mode: MockRequestable.Mode.success(listingSubreddit))
                networker = Networker(requestManager: mockRequestable)
                mockRequestable.resetAll()
            }
            
            it("should return the completion handler with an .invalidURL error if there is an invalid URL") {
                networker.baseURL = "http://en.\n\n\n\n\n\nwikipedia.org/wiki/---)"
                
                waitUntil(action: { (done) in
                    networker.search(query: "fun", { (subreddits, error) in
                        expect(subreddits.isEmpty).to(beTrue())
                        expect(error).to(equal(.invalidURL))
                        done()
                    })
                })
            }
            
            it("should add correct parameters onto the request") {
                let query = "fun"
                let sort = "top"
                
                networker.search(query: query, { _, _ in })
                
                expect(mockRequestable.requestWasCalledWith?.parameters?["q"] as? String).to(equal(query))
                expect(mockRequestable.requestWasCalledWith?.parameters?["sort"] as? String).to(equal(sort))
            }
            
            it("should complete with a list of subreddits on success") {
                waitUntil(action: { (done) in
                    networker.search(query: "fun", { subreddits, error in
                        expect(error).to(beNil())
                        expect(subreddits.isEmpty).to(beFalse())
                        done()
                    })
                })
            }
            
            it("should complete with an empty list of Posts on failure and an error") {
                mockRequestable = MockRequestable(mode: MockRequestable.Mode<Listing<Subreddit>>.failed) as MockRequestable
                networker = Networker(requestManager: mockRequestable)
                mockRequestable.shouldFailWithError = .badRequest
                
                waitUntil(action: { (done) in
                    networker.search(query: "fun", { subreddits, error in
                        expect(error).to(equal(.badRequest))
                        expect(subreddits.isEmpty).to(beTrue())
                        done()
                    })
                })
            }
        }
    }
}
