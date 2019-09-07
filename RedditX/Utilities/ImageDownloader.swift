//
//  ImageDownloader.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import SDWebImage

class ImageDownloader {
    
    let position: Int
    let url: URL
    let downloader: SDWebImageDownloader
    
    private(set) public var image: UIImage?
    
    weak var delegate: ImageDownloaderDelegate?
    
    private var isDownloading: Bool = false
    private var isFinishedDownloading: Bool = false
    
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
                    //TODO: Add ImageDownloaderError.
                    self.delegate?.imageDownloader(self, didFailWith: NSError(), downloading: self.url, at: self.position)
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
