//
//  MockViewController.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class MockViewController: UIViewController {
    
    var removeFromParentWasCalledTimes: Int = 0
    
    override func removeFromParent() {
        removeFromParentWasCalledTimes += 1
    }
}

extension MockViewController: TestResetable {
    
    func resetCounters() {
        removeFromParentWasCalledTimes = 0
    }
    
    func resetParameters() { }
}
