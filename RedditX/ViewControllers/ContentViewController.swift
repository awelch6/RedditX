//
//  ContentViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import SDWebImage

protocol ContentCollectionControllerDelegate: class {
    func collectionView(_ collectionView: ContentCollectionController, didPullToRefresh: Bool)
    func collectionView(_ collectionView: ContentCollectionController, shouldLoadMore: Bool)
}

class ContentCollectionController: UICollectionViewController {
    
    var posts: [Content<Post>] = [] {
        didSet {
            imageCache = [:]
            fetchImages()
        }
    }
    
    var imageCache: [Int: ImageDownloader] = [:]
    
    weak var delegate: ContentCollectionControllerDelegate?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        refreshControl.tintColor = Colors.greenX
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching More Content...", attributes: [.font: Fonts.regular(12), .foregroundColor: Colors.greenX])
        refreshControl.layer.zPosition = -1

        collectionView.refreshControl = refreshControl
        collectionView.backgroundColor = Colors.whiteX
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(ContentCollectionViewCell.self)
    }
    
    private func fetchImages() {
        for (index, post) in posts.enumerated() {
            guard let urlString = post.data.thumbnail, urlString.isValidURL, let url = URL(string: urlString) else {
                continue
            }
            imageCache[index] = ImageDownloader(position: index, url: url, delegate: self)
        }
        collectionView.reloadData()
    }
}

// MARK: Refresh Control Actions

extension ContentCollectionController {
    
    @objc func refreshAction(_ sender: UIRefreshControl) {
        delegate?.collectionView(self, didPullToRefresh: true)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDatasource

extension ContentCollectionController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        var viewModel = ContentViewModel(post: posts[indexPath.item].data)
        viewModel.setImage(imageCache[indexPath.item]?.image)
        cell.display(viewModel: viewModel)
       
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageCache[indexPath.item]?.downloadImage()
        
        if indexPath.item == posts.count - 1 {
            delegate?.collectionView(self, shouldLoadMore: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageCache[indexPath.item]?.cancelDownload()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(PostWebViewController(post: posts[indexPath.item].data), animated: true)
    }
}

// MARK: ImageDownloaderDelegate

extension ContentCollectionController: ImageDownloaderDelegate {
    func imageDownloader(_ imageDownloader: ImageDownloader, downloaded image: UIImage, at position: Int) {
        collectionView.reloadItems(at: [IndexPath(item: position, section: 0)])
    }
    
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int) {
        print("Error: trying to load \(imageURL.absoluteURL) at position: \(postion)")
    }
}
