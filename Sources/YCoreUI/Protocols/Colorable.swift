//
//  Colorable.swift
//  YCoreUI
//
//  Created by Panchami Shenoy on 26/10/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import UIKit

/// Any named color asset that can be loaded from an asset catalog (primarily for use with string-based enums).
///
/// All properties and functions have default implementations. At a minimum just have your string-based enum conform
///  to `Colorable` (and have an asset catalog with matching assets). If your enum and assets live inside a Swift
///  package, override `bundle` to return `.module`. If your assets are categorized within their asset catalog by
///  a namespace, then override `namespace` to return the proper string prefix.
public protocol Colorable: RawRepresentable where RawValue == String {
    /// The bundle containing the color assets for this enum.
    static var bundle: Bundle { get }

    /// Optional namespace for the color assets.
    static var namespace: String? { get }
    
    /// Fallback color to use in case a color asset cannot be loaded.
    static var fallbackColor: UIColor { get }

    /// Loads the named color.
    /// - Returns: The named color or else `nil` if the named asset cannot be loaded
    func loadColor() -> UIColor?
    
    /// A color asset for this name value.
    var color: UIColor { get }
}

extension Colorable {
    /// Returns the `.main` bundle.
    public static var bundle: Bundle { .main }

    /// Returns `nil` to indicate no namespace.
    public static var namespace: String? { nil }
    
    /// Returns `.systemPink` color.
    public static var fallbackColor: UIColor { .systemPink }
    
    /// Returns `UIColor(named:in:compatibleWith:)` passing in the associated `namespace`
    /// (prepended to `rawValue`) and `bundle`.
    public func loadColor() -> UIColor? {
        UIColor(named: calculateName(), in: Self.bundle, compatibleWith: nil)
    }

    internal func calculateName() -> String {
        let name: String
        if let validNamespace = Self.namespace {
            name = "\(validNamespace)/\(rawValue)"
        } else {
            name = rawValue
        }
        return name
    }

    /// Returns `loadColor()` nil-coalesced to `fallbackColor`.
    ///
    /// Unless logging is disabled, a warning message will be logged to the console if the color asset fails to load.
    public var color: UIColor {
        guard let color = loadColor() else {
            if YCoreUI.isLoggingEnabled {
                YCoreUI.colorLogger.warning("Color named \(calculateName()) failed to load from bundle.")
            }
            return Self.fallbackColor
        }
        return color
    }
}
