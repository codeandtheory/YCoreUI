//
//  Localizable.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 11/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import Foundation

/// Any string resource that can be localized (primarily for use with string-based enums)
public protocol Localizable: RawRepresentable where RawValue == String {
    /// The bundle containing the localized strings for this enum
    static var bundle: Bundle { get }

    /// A localized display string for this value
    var localized: String { get }
    
    /// The name of the `.strings` file containing the localized strings for this enum.
    /// `nil` means use the default `Localizable.strings` file
    static var tableName: String? { get }
}

extension Localizable {
    /// The bundle containing the localized strings
    public static var bundle: Bundle { .main }

    /// A localized display string for this value
    public var localized: String {
        rawValue.localized(bundle: Self.bundle, tableName: Self.tableName)
    }
    
    /// The name of the `.strings` file containing the localized strings for this enum.
    /// Returns `nil` to use the default `Localizable.strings` file
    public static var tableName: String? { nil }
}
