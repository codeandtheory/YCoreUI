//
//  ImageAsset.swift
//  YCoreUI
//
//  Created by Dev Karan on 19/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageAsset: RawRepresentable where RawValue == String {
    /// The bundle containing the image assets (default is `.main`)
    static var bundle: Bundle { get }
    
    /// Optional namespace for the image assets (default is `nil`).
    static var namespace: String? { get }
    
    /// Fallback image to use in case an image asset cannot be loaded (default is `.systemPink`)
    static var fallbackImage: UIImage { get }
    
    /// An image asset for this name value.
    ///
    /// Default implementation calls `loadImage` and nil-coalesces to `fallbackImage`.
    var image: UIImage { get }
    
    /// Loads the image.
    ///
    /// - Returns: The named image or else `nil`,If the named asset cannot be loaded.
    func loadImage() -> UIImage?
}

extension ImageAsset {
    /// The bundle containing the image assets (default is `.main`)
    public static var bundle: Bundle { .main }
    
    /// Optional namespace for the image assets (default is `nil`)
    public static var namespace: String? { nil }
    
    /// Loads the named image
    ///
    /// Default implementation uses `UIImage(named:in:compatibleWith:)` passing in the associated `namespace`
    /// (prepended to `rawValue`) and `bundle`.
    /// - Returns: The named image or else `nil` if the named asset cannot be loaded
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
