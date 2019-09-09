//
//  WebViewController.swift
//  RedditX
//
//  Created by Austin Welch on 9/7/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let post: Post
    
    let webView: WKWebView
    
    init(webView: WKWebView = WKWebView(), post: Post) {
        self.post = post
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initial UI Setup

extension WebViewController {
    func setupWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        guard let urlString = post.url, let url = URL(string: urlString) else {
            return
        }
    
        webView.load(URLRequest(url: url))
    }
}
