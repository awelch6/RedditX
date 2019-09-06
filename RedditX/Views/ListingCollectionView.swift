//
//  ListingCollectionView.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ListingsCollectionView: UICollectionView {
    
    let flowLayout: UICollectionViewFlowLayout
    
    var selectedListing: IndexPath?
    
    weak var listingDelegate: ListingCollectionViewDelegate?
    
    init(flowLayout: UICollectionViewFlowLayout = ListingCollectionViewFlowLayout()) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        register(ListingCollectionViewCell.self)
        
        backgroundColor = Colors.whiteX
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UICollectionViewDatasource & UICollectionViewDelegate

extension ListingsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListingType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListingCollectionViewCell = dequeueReusableCell(for: indexPath)
        
        let viewModel = ListingViewModel(listingType: ListingType.allCases[indexPath.item])
        cell.display(viewModel: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedListing != indexPath {
            selectedListing = indexPath
            listingDelegate?.collectionView(self, didSelect: ListingType.allCases[indexPath.item])
        }
    }
}