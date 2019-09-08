//
//  ImageDownloader.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import SDWebImage

private enum ImageDownloaderError: Error {
    case noImage
    case unknown
}

class ImageDownloader {
    
    let position: Int
    let url: URL
    let downloader: SDWebImageDownloader
    
    private(set) var image: UIImage?
    
    private(set) weak var delegate: ImageDownloaderDelegate?
    
    private(set) var isDownloading: Bool = false
    private(set) var isFinishedDownloading: Bool = false
    
    init(downloader: SDWebImageDownloader = SDWebImageDownloader(), position: Int, url: URL, delegate: ImageDownloaderDelegate) {
        self.downloader = downloader
        self.position = position
        self.url = url
        self.delegate = delegate
    }
    
    func downloadImage() {
        if !isDownloading && !isFinishedDownloading && image == nil {
            isDownloading = true
            
            downloader.downloadImage(with: url) { [weak self] (image, _, error, _) in
                guard let self = self else {
                    return
                }
                
                guard error == nil else {
                    self.delegate?.imageDownloader(self, didFailWith: error!, downloading: self.url, at: self.position)
                    return
                }
                
                guard let image = image else {
                    self.delegate?.imageDownloader(self, didFailWith: ImageDownloaderError.noImage, downloading: self.url, at: self.position)
                    return
                }
                
                self.image = image
                self.delegate?.imageDownloader(self, downloaded: image, at: self.position)
                self.isFinishedDownloading = true
            }
        }
    }
    
    func cancelDownload() {
        if isDownloading && !isFinishedDownloading {
            isDownloading = false
            downloader.cancelAllDownloads()
        }
    }
}
