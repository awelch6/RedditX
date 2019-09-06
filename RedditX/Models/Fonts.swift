//
//  Fonts.swift
//  RedditX
//
//  Created by Austin Welch on 9/6/19.
//  Copyright © 2019 Austin Welch. All rights reserved.
//

import UIKit.UIFont

/// A collection of common UIFonts used through the application.
struct Fonts {
    
    //TODO: Figure out how to insert a dependency to allow for better testing.
    
    /// returns the 'Verdana' font for the given size. Otherwise, if the font does not exist, it throws a precondition failure.
    public static func regular(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Verdana", size: size) else {
            preconditionFailure("Unable to find font: Verdana")
        }
        return font
    }
    
    /// returns the 'Verdana-Bold' font for the given size. Otherwise, if the font does not exist, it throws a precondition failure.
    public static func bold(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Verdana-Bold", size: size) else {
            preconditionFailure("Unable to find font: Verdana-Bold")
        }
        return font
    }
    
    /// returns the 'Verdana-Bold' font for the given size. Otherwise, if the font does not exist, it throws a precondition failure.
    public static func boldItalic(_ size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Verdana-Italic", size: size) else {
            preconditionFailure("Unable to find font: Verdana-Italic")
        }
        return font
    }
}
