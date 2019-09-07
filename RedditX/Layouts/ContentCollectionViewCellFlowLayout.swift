//
//  ContentCollectionViewCellFlowLayout.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ContentCollectionViewCellFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setProperties()
    }
    
    private func setProperties() {
        let screenSize = UIScreen.main.bounds
        estimatedItemSize =  CGSize(width: screenSize.width - 20, height: 300)
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
