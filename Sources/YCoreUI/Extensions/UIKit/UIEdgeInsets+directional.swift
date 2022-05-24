//
//  UIEdgeInsets+directional.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 10/11/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    /// Returns the edge insets as directional edge insets.
    /// - Important: this maps .left to .leading, and .right to .trailing,
    /// which may not be correct in a RTL environment.
    /// This is merely a convenience method for converting from non-directional to directional insets.
    var directionalInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(
            top: self.top,
            leading: self.left,
            bottom: self.bottom,
            trailing: self.right
        )
    }
}
