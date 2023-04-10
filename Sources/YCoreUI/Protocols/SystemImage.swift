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
    static var fallbackImage: UIImage { get }

    /// A system image for this name value.
    var image: UIImage { get }
    
    /// Image will scale according to the specified text style.
    ///
    /// Return `nil` to not have the system image scale (not recommended).
    static var textStyle: UIFont.TextStyle? { get }
    
    /// Image configuration to be used to load the system image.
    static var configuration: UIImage.Configuration? { get }

    /// Rendering mode to use for the system image.
    static var renderingMode: UIImage.RenderingMode { get }

    /// Loads the named system image.
    /// - Returns: The named system image or else `nil` if the system image cannot be loaded.
    func loadImage() -> UIImage?
}

extension SystemImage {
    /// Returns a 16 x 16 square filled with `.systemPink`.
    public static var fallbackImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 16, height: 16))
        let image = renderer.image { ctx in
            UIColor.systemPink.setFill()
            ctx.fill(CGRect(origin: .zero, size: renderer.format.bounds.size))
        }
        return image
    }

    /// Returns `.body` text style.
    public static var textStyle: UIFont.TextStyle? { .body }

    /// Returns `UIImage.SymbolConfiguration(textStyle:)`
    /// passing in the specified `textStyle` or else returns `nil` if `textStyle` is `nil`.
    public static var configuration: UIImage.Configuration? {
        guard let textStyle = textStyle else {
            return nil
        }
        return UIImage.SymbolConfiguration(textStyle: textStyle)
    }

    /// Returns `.automatic` rendering mode.
    public static var renderingMode: UIImage.RenderingMode { .automatic }

    /// Returns `UIImage(systemName:)` passing in the associated `rawValue` and `configuration`
    /// and combined with the specified `renderingMode`.
    public func loadImage() -> UIImage? {
        UIImage(systemName: rawValue, withConfiguration: Self.configuration)?.withRenderingMode(Self.renderingMode)
    }

    /// Returns `loadImage()` nil-coalesced to `fallbackImage`.
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
