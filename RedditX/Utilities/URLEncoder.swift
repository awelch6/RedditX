//
//  URLEncoder.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import NetworkX

private enum URLEncodingError: Error {
    case invalidURL
    case unableToParse
}

public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            
            let queryItems = parameters.keys.map { URLQueryItem(name: $0, value: parameters[$0] as? String) }
            
            guard let urlString = urlRequest.url?.absoluteString else {
                throw URLEncodingError.invalidURL
            }
            
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = queryItems
            urlRequest.url = urlComponents?.url
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            throw URLEncodingError.unableToParse
        }
    }
}
