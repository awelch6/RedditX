//
//  TestResetable.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

protocol TestResetable {
    func resetCounters()
    func resetParameters()
    func resetAll()
}

extension TestResetable {
    func resetAll() {
        resetCounters()
        resetParameters()
    }
}
