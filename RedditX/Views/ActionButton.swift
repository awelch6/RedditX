//
//  ActionButton.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 120, height: 40)
    }
    
    init(title: String?, image: UIImage?) {
        super.init(frame: .zero)
        setProperties(title: title, image: image)
    }

    private func setProperties(title: String?, image: UIImage?) {
        setTitle(title, for: .normal)
        setTitleColor(Colors.blackX, for: .normal)
        setImage(image, for: .normal)

        titleLabel?.font = Fonts.bold(15)
        titleLabel?.textAlignment = .center
        
        let insetAmount: CGFloat = 5
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
