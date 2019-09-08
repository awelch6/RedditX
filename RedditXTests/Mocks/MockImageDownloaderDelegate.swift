//
//  MockImageDownloaderDelegate.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import Foundation

@testable import RedditX

class MockImageDownloaderDelegate: ImageDownloaderDelegate {
    
    var downloadedImageWasCalledTimes = 0
    var downloadedImageWasCalledWith: (imageDownloader: ImageDownloader, image: UIImage, position: Int)?
    
    var didFailWithErrorWasCalledTimes = 0
    var didFailWithErrorWasCalledWith: (imageDownloader: ImageDownloader, error: Error, imageURL: URL, postion: Int)?
    
    var imageCache: [Int: ImageDownloader] = [:]
    
    func imageDownloader(_ imageDownloader: ImageDownloader, downloaded image: UIImage, at position: Int) {
        downloadedImageWasCalledTimes += 1
        downloadedImageWasCalledWith = (imageDownloader, image, position)
    }
    
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int) {
        didFailWithErrorWasCalledTimes += 1
        didFailWithErrorWasCalledWith = (imageDownloader, error, imageURL, postion)
    }
}

extension MockImageDownloaderDelegate: TestResetable {
    
    func resetCounters() {
        downloadedImageWasCalledTimes = 0
        didFailWithErrorWasCalledTimes = 0
    }
    
    func resetParameters() {
        downloadedImageWasCalledWith = nil
        didFailWithErrorWasCalledWith = nil
    }
}
