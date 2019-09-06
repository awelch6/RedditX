//
//  ListingCollectionViewCell.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

//TODO: Clean up color logic.
class ListingCollectionViewCell: UICollectionViewCell {
    
    let title: UILabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? Colors.greenX : Colors.whiteX
            title.textColor = isSelected ? Colors.whiteX : Colors.blackX
            contentView.layer.shadowOpacity = isSelected ? 0.4 : 0.1
            contentView.layer.shadowColor = isSelected ? Colors.greenX.cgColor : Colors.shadowX.cgColor
            
            animateSelection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupTitleLabel()
        
        contentView.backgroundColor = Colors.whiteX
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = isSelected ? Colors.greenX.cgColor : Colors.shadowX.cgColor
        contentView.layer.shadowOpacity = isSelected ? 0.4 : 0.1
        contentView.layer.shadowOffset = CGSize(width: 1, height: 3)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
    }
    
    func display(viewModel: ListingViewModel) {
        title.text = viewModel.title
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    func animateSelection(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 15, options: [.curveEaseInOut], animations: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
            }, completion: completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension ListingCollectionViewCell {
    
    private func setupTitleLabel() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.right.left.equalToSuperview().inset(10)
        }
        
        title.font = Fonts.regular(18)
        title.textColor = .black
        title.textAlignment = .center
        title.sizeToFit()
    }
}
