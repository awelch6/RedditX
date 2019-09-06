//
//  ListingCollectionViewDelegate.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

protocol ListingCollectionViewDelegate: class {
    func collectionView(_ collectionView: ListingsCollectionView, didSelect listingType: ListingType)
}
