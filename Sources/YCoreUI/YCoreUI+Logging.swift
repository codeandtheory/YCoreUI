//
//  YCoreUI+Logging.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/16/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import os

/// Y—CoreUI Settings
public struct YCoreUI {
    /// Whether console logging for warnings is enabled. Defaults to `true`.
    public static var isLoggingEnabled = true
}

internal extension YCoreUI {
    /// Logger for warnings related to image loading. cf. `ImageAsset` and `SystemImage`
    static let imageLogger = Logger(subsystem: "YCoreUI", category: "images")
    /// Logger for warnings related to colors. cf `UIColor+rgbValue.swift`
    static let colorLogger = Logger(subsystem: "YCoreUI", category: "colors")
}
