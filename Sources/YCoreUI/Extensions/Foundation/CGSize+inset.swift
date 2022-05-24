//
//  CGSize+inset.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 8/13/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

extension CGSize {
    /// Returns the size increased by the insets' horizontal and vertical values.
    /// Useful for calculating content size.
    /// - Parameter insets: amount to reduce the size by
    /// - Returns: the reduced size value
    public func inset(by insets: NSDirectionalEdgeInsets) -> CGSize {
        CGSize(width: width - insets.horizontal, height: height - insets.vertical)
    }
    
    /// Returns the size increased by the insets' horizontal and vertical values.
    /// Useful for calculating content size.
    /// - Parameter insets: amount to reduce the size by
    /// - Returns: the reduced size value
    public func inset(by insets: UIEdgeInsets) -> CGSize {
        CGSize(width: width - insets.horizontal, height: height - insets.vertical)
    }
    
    /// Returns the size increased by the insets' horizontal and vertical values.
    /// Useful for calculating content size.
    /// - Parameter insets: amount to increase the size by
    /// - Returns: the increased size value
    public func outset(by insets: NSDirectionalEdgeInsets) -> CGSize {
        CGSize(width: width + insets.horizontal, height: height + insets.vertical)
    }
    
    /// Returns the size increased by the insets' horizontal and vertical values.
    /// Useful for calculating content size.
    /// - Parameter insets: amount to increase the size by
    /// - Returns: the increased size value
    public func outset(by insets: UIEdgeInsets) -> CGSize {
        CGSize(width: width + insets.horizontal, height: height + insets.vertical)
    }
}
