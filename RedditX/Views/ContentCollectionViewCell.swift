//
//  ContentCollectionViewCell.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    let authorProfileView = AuthorProfileView()
    let postDetailsView = PostDetailsView()
    let actionButtonView = ActionButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupAuthorProfileView()
        setupPostDetailsView()
        setupActionButtonView()
        
        contentView.backgroundColor = Colors.lightGrayX
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = Colors.shadowX.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
        
    }
    
    func display(viewModel: ContentViewModel) {
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
            make.centerX.width.equalToSuperview()
        }
    }
    
    private func setupActionButtonView() {
        contentView.addSubview(actionButtonView)
        
        actionButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(postDetailsView.snp.bottom).offset(10)
            make.width.centerX.bottom.equalToSuperview()
        }
        
        actionButtonView.upvoteButton.addTarget(self, action: #selector(upvoteButtonPressed(_:)), for: .touchUpInside)
        actionButtonView.downvoteButton.addTarget(self, action: #selector(downvoteButtonPressed(_:)), for: .touchUpInside)
    }
}

// MARK: Button Actions

extension ContentCollectionViewCell {
    
    @objc func upvoteButtonPressed(_ sender: UIButton) {
        
    }
    
    @objc func downvoteButtonPressed(_ sender: UIButton) {
        
    }
}
