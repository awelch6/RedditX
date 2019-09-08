//
//  ContentCollectionControllerDelegate.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

protocol ContentCollectionControllerDelegate: class {
    func collectionView(_ collectionView: ContentCollectionController, didPullToRefresh: Bool)
    func collectionView(_ collectionView: ContentCollectionController, shouldLoadMore after: String?)
}
