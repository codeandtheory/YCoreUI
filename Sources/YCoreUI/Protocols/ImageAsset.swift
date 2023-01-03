//
//  ImageAsset.swift
//  YCoreUI
//
//  Created by Dev Karan on 19/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

/// Any named image asset can be loaded from an asset catalog.
///
/// All properties and functions have default implementations. At a minimum just have your string-based enum conform
///  to `ImageAsset` (and have an asset catalog with matching assets). If your enum and assets live inside a Swift
///  package, override `bundle` to return `.module`. If your assets are categorized within their asset catalog by
///  a namespace, then override `namespace` to return the proper string prefix.
public protocol ImageAsset: RawRepresentable where RawValue == String {
    /// The bundle containing the image assets for this enum (default is `.main`)
    static var bundle: Bundle { get }
    
    /// Optional namespace for the image assets (default is `nil`).
    static var namespace: String? { get }
    
    /// Fallback image to use in case an image asset cannot be loaded.
    /// (default is a 16 x 16 square filled with `.systemPink`)
    static var fallbackImage: UIImage { get }
    
    /// An image asset for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    var image: UIImage { get }
    
    /// Loads the image.
    ///
    /// - Returns: The named image or else `nil` if the named asset cannot be loaded.
    func loadImage() -> UIImage?
}

extension ImageAsset {
    /// The bundle containing the image assets for this enum (default is `.main`)
    public static var bundle: Bundle { .main }
    
    /// Optional namespace for the image assets (default is `nil`)
    public static var namespace: String? { nil }
    
    /// Fallback image to use in case an image asset cannot be loaded.
    /// (default is a 16 x 16 square filled with `.systemPink`)
    public static var fallbackImage: UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 16, height: 16))
        let image = renderer.image { ctx in
            UIColor.systemPink.setFill()
            ctx.fill(CGRect(origin: .zero, size: renderer.format.bounds.size))
        }
        return image
    }
    
    /// Loads the named image.
    ///
    /// Default implementation uses `UIImage(named:in:compatibleWith:)` passing in the associated `namespace`
    /// (prepended to `rawValue`) and `bundle`.
    /// - Returns: The named image or else `nil` if the named asset cannot be loaded.
    public func loadImage() -> UIImage? {
        let name: String
        if let validNamespace = Self.namespace {
            name = "\(validNamespace)/\(rawValue)"
        } else {
            name = rawValue
        }
        return UIImage(named: name, in: Self.bundle, compatibleWith: nil)
    }
    
    /// An image asset for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    public var image: UIImage { loadImage() ?? Self.fallbackImage }
}
