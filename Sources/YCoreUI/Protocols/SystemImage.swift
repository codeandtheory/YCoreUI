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

    /// Optional rendering mode to use for the image (default is `nil`)
    static var renderingMode: UIImage.RenderingMode? { get }

    /// A system image for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    var image: UIImage { get }
    
    /// Image will scale according to the specified text style.
    ///
    /// Default implementation is `.body`.
    static var textStyle: UIFont.TextStyle? { get }
    
    /// Image configuration to be used in `loadImage()`.
    ///
    /// Default implementation is `UIImage.SymbolConfiguration(textStyle: textStyle)`.
    /// Returns `nil` when `textStyle` is `nil`.
    static var configuration: UIImage.Configuration? { get }

    /// Loads the named system image.
    /// - Returns: The named system image or else `nil` if the system image cannot be loaded.
    func loadImage() -> UIImage?
}

extension SystemImage {
    /// Image will scale according to the specified text style.
    public static var textStyle: UIFont.TextStyle? { .body }

    /// Optional rendering mode to use for the image (default is `nil`)
    public static var renderingMode: UIImage.RenderingMode? { nil }

    /// Image configuration to be used in `loadImage()`.
    ///
    /// Returns `nil` when `textStyle` is `nil`.
    public static var configuration: UIImage.Configuration? {
        guard let textStyle = textStyle else {
            return nil
        }
        return UIImage.SymbolConfiguration(textStyle: textStyle)
    }
    
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
        let image = UIImage(systemName: rawValue, withConfiguration: Self.configuration)
        guard let renderingMode = Self.renderingMode else {
            return image
        }
        return image?.withRenderingMode(renderingMode)
    }

    /// A system image for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    public var image: UIImage {
        guard let image = loadImage() else {
            if YCoreUI.isLoggingEnabled {
                YCoreUI.imageLogger.warning("System image named \(rawValue) failed to load.")
            }
            return Self.fallbackImage
        }

        return image
    }
}
