//
//  SearchResultTableViewCell.swift
//  RedditX
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    func display(viewModel: SearchViewModel) {
        textLabel?.numberOfLines = 2
        textLabel?.attributedText = viewModel.attributedText
        
        imageView?.image = nil
        imageView?.image = viewModel.icon
    }
}
