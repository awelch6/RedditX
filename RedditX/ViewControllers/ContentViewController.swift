//
//  ContentViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import SDWebImage

class ContentCollectionViewController: UICollectionViewController {
    
    var content: [Content] = [] {
        didSet {
            imageCache = [:]
            fetchImages()
        }
    }
    
    var imageCache: [Int: ImageDownloader] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = Colors.whiteX
        collectionView.register(ContentCollectionViewCell.self)
    }
    
    private func fetchImages() {
        for (index, content) in content.enumerated() {
            guard let urlString = content.post.thumbnail, urlString.isValidURL, let url = URL(string: urlString) else {
                continue
            }
            imageCache[index] = ImageDownloader(position: index, url: url, delegate: self)
        }
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDatasource

extension ContentCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.postDetailsView.thumbnail.image = nil
        
        var viewModel = ContentViewModel(content: content[indexPath.item])
        viewModel.setImage(imageCache[indexPath.item]?.image)
        cell.display(viewModel: viewModel)
       
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageCache[indexPath.item]?.downloadImage()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageCache[indexPath.item]?.cancelDownload()
    }
}

// MARK: ImageDownloaderDelegate

extension ContentCollectionViewController: ImageDownloaderDelegate {
    func imageDownloader(_ imageDownloader: ImageDownloader, downloaded image: UIImage, at position: Int) {
        collectionView.reloadItems(at: [IndexPath(item: position, section: 0)])
    }
    
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int) {
        print("Error: trying to load \(imageURL.absoluteURL) at position: \(postion)")
    }
}
