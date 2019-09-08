//
//  SearchResultTableController.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class SearchResultTableController: UITableViewController {
    
    var subreddits = [Content<Subreddit>]() {
        didSet { fetchIcons() }
    }
    
    var imageCache: [Int: ImageDownloader] = [:]
    
    weak var delegate: SearchResultTableControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

// MARK: Initial UI Setup

extension SearchResultTableController {
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 65
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = true
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchResultTableViewCell.self)
    }
}

// MARK: Utilities

extension SearchResultTableController {
    
    private func fetchIcons() {
        for (index, subreddit) in subreddits.enumerated() {
            guard let urlString = subreddit.data.iconURL, urlString.isValidURL, let url = URL(string: urlString) else {
                continue
            }
            imageCache[index] = ImageDownloader(position: index, url: url, delegate: self)
        }
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate & UITableViewDatasource

extension SearchResultTableController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        var viewModel = SearchViewModel(subreddit: subreddits[indexPath.row].data)
        viewModel.setImage(imageCache[indexPath.row]?.image)
        
        cell.display(viewModel: viewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchResult(self, didSelect: subreddits[indexPath.row].data)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageCache[indexPath.row]?.downloadImage()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageCache[indexPath.row]?.cancelDownload()
    }
}

// MARK: ImageDownloaderDelegate

extension SearchResultTableController: ImageDownloaderDelegate {
    
    func imageDownloader(_ imageDownloader: ImageDownloader, downloaded image: UIImage, at position: Int) {
        tableView.reloadRows(at: [IndexPath(item: position, section: 0)], with: .automatic)
    }
    
    func imageDownloader(_ imageDownloader: ImageDownloader, didFailWith error: Error, downloading imageURL: URL, at postion: Int) {
        print("Error: trying to load \(imageURL.absoluteURL) at position: \(postion)")
    }
}
