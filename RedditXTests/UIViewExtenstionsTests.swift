//
//  UIViewExtenstionsTests.swift
//  RedditXTests
//
//  Created by Austin Welch on 9/8/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import Quick
import Nimble

@testable import RedditX

class UIViewExtensionsTests: QuickSpec {
    
    override func spec() {
        
        var view: UIView!
        
        beforeEach {
            view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        }
        
        it("should add a CAShapeLayer when roundCorners is called") {
            view.roundCorners(corners: [.topLeft, .topRight], radius: 10)
            
            expect(view.layer.mask).notTo(beNil())
        }
        
        it("should style the view's layer correctly when addShadow is called") {
            let color = UIColor.blue.cgColor
            let opacity: Float = 0.1
            let offset = CGSize(width: 0, height: 0)
            let shadowRadius: CGFloat = 1
            
            view.addShadow(color: color, opacity: opacity, offset: offset, shadowRadius: shadowRadius)
            
            expect(view.layer.shadowColor).to(equal(color))
            expect(view.layer.shadowOpacity).to(equal(opacity))
            expect(view.layer.shadowOffset).to(equal(offset))
            expect(view.layer.shadowRadius).to(equal(shadowRadius))
        }
    }
}
