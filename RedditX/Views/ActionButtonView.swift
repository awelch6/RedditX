//
//  ActionButtonView.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ActionButtonView: UIView {
    
    let upvoteButton = ActionButton(title: "Up Vote", image: UIImage(named: "up-vote"))
    let downvoteButton = ActionButton(title: "Down Vote", image: UIImage(named: "down-vote"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupActionButtons()
        
        backgroundColor = Colors.whiteX
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomRight, .bottomLeft], radius: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension ActionButtonView {
    
    private func setupActionButtons() {
        addSubview(upvoteButton)
        upvoteButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().dividedBy(2)
        }
        
        addSubview(downvoteButton)
        downvoteButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(1.5)
        }
    }
}
