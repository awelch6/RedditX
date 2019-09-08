//
//  URLEncoderTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble
import NetworkX

@testable import RedditX

class URLEncoderTests: QuickSpec {
    
    override func spec() {
        
        var urlEncoder: URLParameterEncoder!
        var urlRequest: URLRequest!
        
        let url = URL(string: "www.mockURL.com")!
            
        beforeEach {
            urlEncoder = URLParameterEncoder()
            urlRequest = URLRequest(url: url)
        }
        
        it("should throw URLEncodingError if the URLRequest does not have a url") {
           
            urlRequest.url = nil
            expect {
                try urlEncoder.encode(urlRequest: &urlRequest, with: [:])
            }.to(throwError())
        }
        
        it("should append parameters to end of the url") {
            let expectedURLString = "www.mockURL.com?q=search"
            let parameters: Parameters = ["q": "search"]
            
            expect {
                try urlEncoder.encode(urlRequest: &urlRequest, with: parameters)
            }.notTo(throwError())
            
            expect(urlRequest.url?.absoluteString).to(equal(expectedURLString))
        }
        
        it("should append correct headers") {
            expect {
                try urlEncoder.encode(urlRequest: &urlRequest, with: [:])
                }.notTo(throwError())
            
            expect(urlRequest.allHTTPHeaderFields?["Content-Type"]).to(equal("application/json"))
        }
    }
}
