//
//  PostDetailsView.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import SnapKit

class PostDetailsView: UIView {
    
    let titleLabel = UILabel()
    let thumbnail = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func display(viewModel: ContentViewModel) {        
        thumbnail.snp.removeConstraints()
        titleLabel.snp.removeConstraints()
        
        setupTitleLabel(viewModel.title)

        if let image = viewModel.image {
            setupThumbnail(image)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension PostDetailsView {
    
    private func setupTitleLabel(_ title: String?) {
        addSubview(titleLabel)
        
        titleLabel.snp.remakeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.top.width.equalToSuperview().inset(10)
        }
        
        titleLabel.text = title
        titleLabel.font = Fonts.bold(16)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Colors.blackX
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
    }
    
    private func setupThumbnail(_ image: UIImage) {
        addSubview(thumbnail)
        
        titleLabel.snp.remakeConstraints { (remake) in
            remake.centerX.equalToSuperview()
            remake.top.width.equalToSuperview().inset(10)
        }
        
        thumbnail.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.bottom.equalToSuperview()
        }
        
        thumbnail.image = image
        thumbnail.contentMode = .scaleAspectFit
    }
}
