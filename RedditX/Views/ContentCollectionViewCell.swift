//
//  ContentCollectionViewCell.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    var authorProfileView = AuthorProfileView()
    var postDetailsView = PostDetailsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Colors.lightGrayX
        
        setupAuthorProfileView()
        setupPostDetailsView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
        contentView.addShadow(color: Colors.shadowX.cgColor, opacity: 0.2, offset: CGSize(width: 0, height: 2), shadowRadius: 5)
    }
    
    func display(viewModel: ContentViewModel) {
        postDetailsView.thumbnail.image = nil //clear out any reused image when cell is being displayed.
        
        authorProfileView.thumbnail.image = UIImage(named: "reddit")
        authorProfileView.authorDetailsLabel.attributedText = viewModel.authorName
        postDetailsView.display(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension ContentCollectionViewCell {
    
    private func setupAuthorProfileView() {
        contentView.addSubview(authorProfileView)
        
        authorProfileView.snp.makeConstraints { (make) in
            make.top.width.centerX.equalToSuperview()
        }
    }
    
    private func setupPostDetailsView() {
        contentView.addSubview(postDetailsView)
        
        postDetailsView.snp.makeConstraints { (make) in
            make.top.equalTo(authorProfileView.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
}
