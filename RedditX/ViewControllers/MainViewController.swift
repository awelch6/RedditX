//
//  ViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import SnapKit

/*
 // TODO:
 - Add loading animations
 */

class MainViewController: UIViewController {

    lazy var searchController = UISearchController(searchResultsController: searchResultTableController)
    let searchResultTableController = SearchResultTableController()
    let listingCollectionView = ListingsCollectionView(flowLayout: ListingCollectionViewFlowLayout())
    let contentCollectionController = ContentCollectionController(collectionViewLayout: ContentCollectionViewCellFlowLayout())
    let networker: Netoworkable
    
    init(networker: Netoworkable = Networker()) {
        self.networker = networker
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupListingCollectionView()
        setupContentCollectionViewController()
        setupSearchController()
        
        searchResultTableController.delegate = self
        
        definesPresentationContext = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension MainViewController {
    
    func setupListingCollectionView() {
        view.addSubview(listingCollectionView)
        
        listingCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        listingCollectionView.listingDelegate = self
    }
    
    func setupContentCollectionViewController() {
        add(contentCollectionController)
        contentCollectionController.view.snp.makeConstraints { (make) in
            make.top.equalTo(listingCollectionView.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "r/"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: SearchResultsUpdater

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        networker.search(query: searchText) { (subreddits, error) in
            guard error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let searchResultsController = searchController.searchResultsController as? SearchResultTableController else {
                return
            }
            
            searchResultsController.subreddits = subreddits
        }
    }
}

// MARK: ListingCollectionViewDelegate

extension MainViewController: ListingCollectionViewDelegate {
    
    func collectionView(_ collectionView: ListingsCollectionView, didSelect listingType: ListingType) {
        networker.request(listing: listingType) { [weak self] (posts, error) in
            guard let self = self, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unable to find reference to self!")")
                return
            }
            
            self.contentCollectionController.posts = posts
        }
    }
}

extension MainViewController: SearchResultTableControllerDelegate {
    
    func searchResult(_ searchResultTableController: SearchResultTableController, didSelect subreddit: Subreddit) {
        
        searchController.isActive = false
        
        networker.request(subreddit: subreddit.url) { [weak self] (posts, error) in
            guard let self = self, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unable to find reference to self!")")
                return
            }
            
            self.contentCollectionController.posts = posts
        }
    }
}

protocol SearchResultTableControllerDelegate: class {
    func searchResult(_ searchResultTableController: SearchResultTableController, didSelect subreddit: Subreddit)
}

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

// MARK: UIScrollViewDelegate

extension SearchResultTableController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
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

struct SearchViewModel {
    
    var attributedText: NSMutableAttributedString {
        var titleAttributes = NSMutableAttributedString()

        titleAttributes = NSMutableAttributedString(string: subreddit.name + "\n",
                                                        attributes: [.font: Fonts.bold(16), .foregroundColor: Colors.blackX])

        if let subscriberCount = formattedSubscriberCount {
            let string = "Community • \(subscriberCount) members"
            let attributes = NSMutableAttributedString(string: string,
                                                       attributes: [.font: Fonts.regular(12), .foregroundColor: Colors.grayX])
            titleAttributes.append(attributes)
        }
        
        return titleAttributes
        
    }
    
    var formattedSubscriberCount: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: subreddit.subscribers))
    }
    
    private(set) var icon: UIImage?
    
    private let subreddit: Subreddit
    
    init(subreddit: Subreddit) {
        self.subreddit = subreddit
    }

    mutating func setImage(_ image: UIImage?) {
        self.icon = image
    }
}

class SearchResultTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if let imageView = imageView {
            imageView.layer.cornerRadius = imageView.frame.height / 2
        }
    }
    
    func display(viewModel: SearchViewModel) {
        imageView?.image = nil
        textLabel?.attributedText = viewModel.attributedText
        textLabel?.numberOfLines = 2
        imageView?.image = viewModel.icon
    }
}
