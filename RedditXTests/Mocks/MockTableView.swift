//
//  MockTableView.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

class MockTableView: UITableView {
    
    var reloadRowsWasCalledTimes = 0
    var reloadRowsWasCalledWith: (indexPaths: [IndexPath], animation: UITableView.RowAnimation)?
    
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        reloadRowsWasCalledTimes += 1
        reloadRowsWasCalledWith = (indexPaths, animation)
    }
}

// MARK: TestResetable

extension MockTableView: TestResetable {
    
    func resetCounters() {
        reloadRowsWasCalledTimes += 1
    }
    
    func resetParameters() {
        reloadRowsWasCalledWith = nil
    }
}
