//
//  UIEdgeInsets+horizontal.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 8/11/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    /// Sum of top and bottom insets
    public var vertical: CGFloat { top + bottom }
    
    /// Sum of left and right insets
    public var horizontal: CGFloat { left + right }
}
