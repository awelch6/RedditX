//
//  ContentViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class ContentCollectionViewController: UICollectionViewController {
    
    var content: [String] = [] {
        didSet { collectionView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ContentCollectionViewCell.self)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDatasource

extension ContentCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

struct ContentViewModel {
    
}

struct AuthorProfileViewModel {
    
    var image: UIImage? {
        return UIImage(named: "Image")
    }
    
    var authorDetails: NSMutableAttributedString {
        let titleAttributes = NSMutableAttributedString(string: "Mason Douglas" + "\n",
                                                        attributes: [.font: Fonts.bold(16), .foregroundColor: Colors.blackX])
        
        //default color to white for now because a color property does not exist on the response.
        let attributes = NSMutableAttributedString(string: "12:35pm", attributes: [.font: Fonts.regular(14), .foregroundColor: Colors.greyX])
        titleAttributes.append(attributes)
        
        return titleAttributes
    }
}

class AuthorProfileView: UIView {
    
    let profileImageView = UIImageView()
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
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func display(viewModel: AuthorProfileViewModel) {
        profileImageView.image = viewModel.image
        authorDetailsLabel.attributedText = viewModel.authorDetails
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
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
    
    private func setupPostDetailsLabel() {
        addSubview(authorDetailsLabel)
        
        authorDetailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(profileImageView.snp.right).inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

class ContentCollectionViewCell: UICollectionViewCell {
    
    let authorProfileView = AuthorProfileView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    func display(viewModel: ContentViewModel) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContentCollectionViewCellFlowLayout: UICollectionViewFlowLayout {
    
}
