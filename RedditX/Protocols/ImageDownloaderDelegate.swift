//
//  ImageDownloaderDelegate.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit.UIImage

protocol ImageDownloaderDelegate: class {
    var imageCache: [Int: ImageDownloader] { get set }
    
    func imageDownloader(_ imageDownloader: ImageDownloader, downloaded image: UIImage, at position: Int)
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int)
}

extension ImageDownloaderDelegate {
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int) { }
}
