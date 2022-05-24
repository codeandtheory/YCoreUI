//
//  UIScreen+scaleFactor.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 8/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIScreen {
    /// Represents possible scale factors of iOS screens
    public enum ScaleFactor: CGFloat {
        /// 1x: non-retina screen
        case single = 1
        /// 2x: original retina screen
        case double = 2
        /// 3x: higher density retina screen
        case triple = 3
        
        // Add additional cases here when 4x, 5x screens become available
    }
    
    /// The natural scale factor associated with the screen
    public var scaleFactor: ScaleFactor {
        ScaleFactor(rawValue: scale) ?? .triple
    }
}
