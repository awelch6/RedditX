//
//  MockSDWebImageDownloader.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import SDWebImage

@testable import RedditX

class MockSDWebImageDownloader: SDWebImageDownloader {
    
    var downloadImageWasCalledTimes = 0
    var downloadImageWasCalledWith: (url: URL?, completedBlock: SDWebImageDownloaderCompletedBlock?)?
    
    var cancelDownloadWasCalledTimes = 0
    
    var shouldFailWithError: Error?
    var imageToReturn = UIImage(named: "reddit")
    
    var shouldCallCompletion: Bool = true
    
    override func downloadImage(with url: URL?, completed completedBlock: SDWebImageDownloaderCompletedBlock? = nil) -> SDWebImageDownloadToken? {
        downloadImageWasCalledTimes += 1
        downloadImageWasCalledWith = (url, completedBlock)
        
        if shouldCallCompletion { //We may want to test the imageDownloader in a 'downloading' state.
            completedBlock?(imageToReturn, nil, shouldFailWithError, false)
        }
        
        return nil
    }
    
    override func cancelAllDownloads() {
        cancelDownloadWasCalledTimes += 1
    }
}

extension MockSDWebImageDownloader: TestResetable {
    func resetCounters() {
        downloadImageWasCalledTimes = 0
        cancelDownloadWasCalledTimes = 0
    }
    
    func resetParameters() {
        downloadImageWasCalledWith = nil
        shouldFailWithError = nil
        shouldCallCompletion = true
    }
}
