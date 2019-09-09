//
//  UIViewControllerExtensionsTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class UIViewControllerExtensionTests: QuickSpec {
    
    override func spec() {
        
        var parentViewController: UIViewController!
        var childViewController: UIViewController!
        
        beforeEach {
            parentViewController = UIViewController()
            childViewController = UIViewController()
        }
        
        it("should add a new childViewController to the parent") {
            parentViewController.add(childViewController)
            
            expect(parentViewController.children.count).to(equal(1))
            expect(parentViewController.children.contains(childViewController)).to(beTrue())
        }
        
        it("should remove an existing child from its parent") {
            parentViewController.add(childViewController)
            
            childViewController.remove()
            
            expect(parentViewController.children.count).to(equal(0))
            expect(parentViewController.children.contains(childViewController)).to(beFalse())
        }
        
        it("should return if no parent exists") {
            let mockViewController = MockViewController()

            mockViewController.remove()
            
            expect(mockViewController.removeFromParentWasCalledTimes).to(equal(0))
        }
    }
}
