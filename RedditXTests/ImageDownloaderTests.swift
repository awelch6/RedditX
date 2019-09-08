//
//  ImageDownloaderTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble
import SDWebImage
import NetworkX

@testable import RedditX

class ImageDownloaderTests: QuickSpec {
    override func spec() {
        
        var imageDownloader: ImageDownloader!
        let mockImageDownloader = MockSDWebImageDownloader()
        let mockImageDownloaderDelegate = MockImageDownloaderDelegate()
        let url = URL(string: "www.mockURL.com")!
        let position = 0
        
        beforeEach {
            imageDownloader = ImageDownloader(downloader: mockImageDownloader, position: position, url: url, delegate: mockImageDownloaderDelegate)
        }
        
        context("when a new imageDownloader is initialized") {
            
            it("should have a non-nil value for the delegate property") {
                expect(imageDownloader.delegate).notTo(beNil())
            }
            
            it("should have 'isDownloading' property set to false") {
                 expect(imageDownloader.isDownloading).to(beFalse())
            }
            
            it("should have 'isFinishedDownloading' property set to false") {
                expect(imageDownloader.isFinishedDownloading).to(beFalse())

            }
            
            it("should have a nil value for 'image' property") {
                expect(imageDownloader.image).to(beNil())
            }
        }
        
        context("when 'downloadImage' is called") {
            
            beforeEach {
                imageDownloader = ImageDownloader(downloader: mockImageDownloader, position: position, url: url, delegate: mockImageDownloaderDelegate)
                mockImageDownloader.resetAll()
                mockImageDownloaderDelegate.resetAll()
            }
            
            it("should set is downloading to true if an image does not exist, and is not currently being downloaded and hasn't finished downloading") {
                imageDownloader.downloadImage()
                expect(imageDownloader.isDownloading).to(beTrue())
            }
            
            it("should call downloadImage on a the SDWebImageDownloader if an image does not exist, and is not currently being downloaded and hasn't finished downloading") {
                imageDownloader.downloadImage()
                expect(mockImageDownloader.downloadImageWasCalledTimes).to(equal(1))
                expect(mockImageDownloader.downloadImageWasCalledWith?.url).to(equal(url))
            }
            
            it("should call nothing if an image does exist or is currently being downloaded or has finished downloading") {
                imageDownloader.downloadImage() // simulate downloading an initial image.
                
                imageDownloader.downloadImage()
                
                expect(mockImageDownloader.downloadImageWasCalledTimes).to(equal(1)) //should equal 1 to account for the initial call.
            }
            
            it("should call didFailWithError if an error occurs while downloading an image") {
                mockImageDownloader.shouldFailWithError = NetworkError.badRequest
                
                imageDownloader.downloadImage()
                
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledTimes).to(equal(1))
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledWith?.imageURL).to(equal(url))
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledWith?.postion).to(equal(position))
            }
            
            it("should call didFailrWithError if no error occurs but the image is nil") {
                mockImageDownloader.imageToReturn = nil
                
                imageDownloader.downloadImage()
                
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledTimes).to(equal(1))
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledWith?.imageURL).to(equal(url))
                expect(mockImageDownloaderDelegate.didFailWithErrorWasCalledWith?.postion).to(equal(position))
            }
            
            it("should set the image property if no error occurs and an image exists") {
                let image = UIImage(named: "reddit")
                mockImageDownloader.imageToReturn = image
                
                imageDownloader.downloadImage()
                
                expect(imageDownloader.image).to(equal(image))
            }
            
            it("should call downloadedImage if no error occurs and an image exists") {
                let image = UIImage(named: "reddit")
                mockImageDownloader.imageToReturn = image
                
                imageDownloader.downloadImage()
                
                expect(mockImageDownloaderDelegate.downloadedImageWasCalledTimes).to(equal(1))
                expect(mockImageDownloaderDelegate.downloadedImageWasCalledWith?.image).to(equal(image))
            }
            
            it("should set the isFinishedDownloading property to true if no error occurs and an image exists") {
                mockImageDownloader.imageToReturn = UIImage(named: "reddit")
                
                imageDownloader.downloadImage()
                
                expect(imageDownloader.isFinishedDownloading).to(beTrue())
            }
        }
        
        context("when cancelDownload is called") {
            
            beforeEach {
                imageDownloader = ImageDownloader(downloader: mockImageDownloader, position: position, url: url, delegate: mockImageDownloaderDelegate)
                mockImageDownloader.resetAll()
                mockImageDownloaderDelegate.resetAll()
            }
            
            it("should set isDownloading to false if the image is currently downloading and hasn't finished downloading") {
                mockImageDownloader.shouldCallCompletion = false
                
                imageDownloader.downloadImage() // simulates a long download since the competion handler will never be called.
                imageDownloader.cancelDownload()
                
                expect(imageDownloader.isDownloading).to(beFalse())
            }
            
            it("should call cancelAllDownloads if the image is currently downloading and hasn't finished downloading") {
                mockImageDownloader.shouldCallCompletion = false
                
                imageDownloader.downloadImage() // simulates a long download since the competion handler will never be called.
                imageDownloader.cancelDownload()
                
                expect(mockImageDownloader.cancelDownloadWasCalledTimes).to(equal(1))
            }
            
            it("should call nothing if the iumage isn't downloading or has finished downloading") {
                imageDownloader.cancelDownload()
                
                expect(imageDownloader.isDownloading).to(beFalse())
                expect(mockImageDownloader.cancelDownloadWasCalledTimes).to(equal(0))
            }
        }
    }
}
