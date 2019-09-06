//
//  ViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import NetworkX

/*
 // TODO:
 - Create a 'ListingsCollectionView'
 - Create a collectionView to show each post
 - Create innovative way to show search results
 - Create WebView to show reddit
 - Make network layer into its own pod
 - Find a way to manage images on some posts and not others.
 */

class ViewController: UIViewController {

    let requestManager = RequestManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
    }
}
