//
//  SystemImage.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 3/8/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit

/// Any string corresponding to a system image (SF Symbols).
///
/// All properties and functions have default implementations. At a minimum just have your string-based enum conform
///  to `SystemImage`.  The raw value of the enum should match a sytem image name (e.g. `checkmark.seal`).
public protocol SystemImage: RawRepresentable where RawValue == String {
    /// Fallback image to use in case a system image cannot be loaded.
    /// (default is a 16 x 16 square filled with `.systemPink`)
    static var fallbackImage: UIImage { get }

    /// A system image for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    var image: UIImage { get }

    /// Loads the named system image.
    /// - Returns: The named system image or else `nil` if the system image cannot be loaded.
    func loadImage() -> UIImage?
}

extension SystemImage {
    /// Fallback image to use in case a system image cannot be loaded.
    /// (default is a 16 x 16 square filled with `.systemPink`)
    public static var fallbackImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 16, height: 16))
        let image = renderer.image { ctx in
            UIColor.systemPink.setFill()
            ctx.fill(CGRect(origin: .zero, size: renderer.format.bounds.size))
        }
        return image
    }

    /// Loads the named system image.
    ///
    /// Default implementation uses `UIImage(systemName:)` passing in the associated `rawValue`.
    /// - Returns: The named system image or else `nil` if the system image cannot be loaded.
    public func loadImage() -> UIImage? {
        UIImage(systemName: rawValue)
    }

    /// A system image for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    public var image: UIImage { loadImage() ?? Self.fallbackImage }
}
