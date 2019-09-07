//
//  AuthorProfileView.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class AuthorProfileView: UIView {
    
    let thumbnail = UIImageView()
    let authorDetailsLabel = UILabel()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: 65)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setProperties()
        setupProfileImageView()
        setupPostDetailsLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        thumbnail.layer.cornerRadius = thumbnail.frame.height / 2
        roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    private func setProperties() {
        backgroundColor = Colors.whiteX
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension AuthorProfileView {
    
    private func setupProfileImageView() {
        addSubview(thumbnail)
        
        thumbnail.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(35)
        }
    }
    
    private func setupPostDetailsLabel() {
        addSubview(authorDetailsLabel)
        
        authorDetailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(thumbnail.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        authorDetailsLabel.numberOfLines = 2
        authorDetailsLabel.textAlignment = .left
        authorDetailsLabel.sizeToFit()
    }
}
