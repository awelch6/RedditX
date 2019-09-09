//
//  ViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    lazy var searchController: UISearchController = {
        let searchResultTableController = SearchResultTableController()
        searchResultTableController.delegate = self
        return UISearchController(searchResultsController: searchResultTableController)
    }()
    
    let listingCollectionView = ListingsCollectionView(flowLayout: ListingCollectionViewFlowLayout())
    let contentCollectionController = ContentCollectionController(collectionViewLayout: ContentCollectionViewFlowLayout())
    let networker: Netoworkable
    
    var currentSubreddit: String = ListingType.best.rawValue
    
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

        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // trigger 'Popular' to load once the view is about to appear
        listingCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        listingCollectionView.collectionView(listingCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Utilities

extension MainViewController {
    
    func loadContent(subreddit: String, limit: Int = 10, after: String? = nil, _ completion: @escaping (() -> Void) = { }) {
        networker.request(subreddit: subreddit, limit: limit, after: after) { [weak self] (posts, error) in
            guard let self = self, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unable to find reference to self!")")
                return completion()
            }
            
            if after != nil {
                self.contentCollectionController.add(posts: posts, clearExisting: false)
            } else {
                self.contentCollectionController.add(posts: posts, clearExisting: true)
            }
            
            completion()
        }
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
        
        contentCollectionController.delegate = self
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
        searchController.isActive = false
        currentSubreddit = listingType.rawValue
        loadContent(subreddit: listingType.rawValue)
    }
}

// MARK: SearchResultTableControllerDelegate

extension MainViewController: SearchResultTableControllerDelegate {
    
    func searchResult(_ searchResultTableController: SearchResultTableController, didSelect subreddit: Subreddit) {
        
        currentSubreddit = subreddit.name
        searchController.isActive = false
        
        if let selectedListing = listingCollectionView.selectedListing {
            listingCollectionView.selectedListing = nil
            listingCollectionView.deselectItem(at: selectedListing, animated: false)
        }
        
        loadContent(subreddit: subreddit.name)
    }
}

// MARK: ContentCollectionControllerDelegate

extension MainViewController: ContentCollectionControllerDelegate {
    
    func collectionView(_ collectionView: ContentCollectionController, didPullToRefresh: Bool) {
        loadContent(subreddit: currentSubreddit) {
            collectionView.refreshControl.endRefreshing()
        }
    }
    
    func collectionView(_ collectionView: ContentCollectionController, shouldLoadMore after: String?) {
        loadContent(subreddit: currentSubreddit, limit: 3, after: after)
    }
}
