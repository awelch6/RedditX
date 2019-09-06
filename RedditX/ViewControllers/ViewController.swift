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
 - Create a collectionView to show each post
 - Create innovative way to show search results
 - Create WebView to show reddit
 - Make network layer into its own pod
 - Find a way to manage images on some posts and not others.
 */

class ViewController: UIViewController {

    let listingCollectionView = ListingsCollectionView(flowLayout: ListingCollectionViewFlowLayout())
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension ViewController {
    
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
        
    }
}

// MARK: ListingCollectionViewDelegate

extension ViewController: ListingCollectionViewDelegate {
    func collectionView(_ collectionView: ListingsCollectionView, didSelect listingType: ListingType) {
        networker.request(listing: listingType) { (listing, error) in
            print(listing)
            print(error)
        }
    }
}
