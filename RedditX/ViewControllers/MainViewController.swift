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
 - Create innovative way to show search results
 - Create Search bar
 - Add loading animations
 */

class MainViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)

    let listingCollectionView = ListingsCollectionView(flowLayout: ListingCollectionViewFlowLayout())
    let contentCollectionViewController = ContentCollectionViewController(collectionViewLayout: ContentCollectionViewCellFlowLayout())
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
        
        navigationItem.titleView = searchController.searchBar
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
        add(contentCollectionViewController)
        contentCollectionViewController.view.snp.makeConstraints { (make) in
            make.top.equalTo(listingCollectionView.snp.bottom)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
}

// MARK: ListingCollectionViewDelegate

extension MainViewController: ListingCollectionViewDelegate {
    func collectionView(_ collectionView: ListingsCollectionView, didSelect listingType: ListingType) {
        networker.request(listing: listingType) { (content, _) in
            self.contentCollectionViewController.content = content
        }
    }
}
