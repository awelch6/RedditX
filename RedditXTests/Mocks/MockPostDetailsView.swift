//
//  MockPostDetailsView.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit

@testable import RedditX

class MockPostDetailsView: PostDetailsView {
    
    var displayWasCalledTimes = 0
    
    override func display(viewModel: ContentViewModel) {
        displayWasCalledTimes += 1
    }
}

extension MockPostDetailsView: TestResetable {
    func resetCounters() {
        displayWasCalledTimes = 0
    }
    
    func resetParameters() { }
}
