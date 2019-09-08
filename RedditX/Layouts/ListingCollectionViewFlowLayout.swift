//
//  ListingCollectionViewFlowLayout.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ListingCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setProperties()
    }
    
    private func setProperties() {
        minimumInteritemSpacing = 12
        estimatedItemSize = CGSize(width: 40, height: 30) //estimated size needs to be a non-zero value to allow the cells to auto-size based on their text
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
