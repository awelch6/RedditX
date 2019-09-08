//
//  Resuable.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

protocol Resuable: class { }

extension Resuable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: UICollectionView

extension UICollectionViewCell: Resuable { }

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Unable to dequeue cell!")
        }
        
        return cell
    }
}

// MARK: UITableView

extension UITableViewCell: Resuable { }

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Unable to dequeue cell!")
        }
        
        return cell
    }
}
