//
//  Colorable.swift
//
//  Created by Y Media Labs on 25/10/22.
//
import UIKit

///  Protocol for string based enum that has names of color assets
public protocol Colorable: RawRepresentable where RawValue == String {
    /// The bundle containing the localized strings for this enum
    static var bundle: Bundle { get }

    /// Namespace for color asset
    static var namespace: String? { get }
    
    /// Color to display error cases
    static var fallbackColor: UIColor { get }
    
    /// Color to be displayed based on namespace
    /// - Returns: Color to be displayed
    func loadColor() -> UIColor?
    
    /// Color to be displayed
    var color: UIColor { get }
}

/// Default implementation the `Colorable`
extension Colorable {
    /// The bundle containing the localized strings
    static var bundle: Bundle { .main }

    /// Namespace for color asset
    static var namespace: String? { nil }
    
    /// Color to display error cases
    static var fallbackColor: UIColor { .systemPink }
    
    /// Color to be displayed based on namespace
    /// - Returns: Color to be displayed
    func loadColor() -> UIColor? {
        let name: String
        if let validNamespace = Self.namespace {
            name = "\(validNamespace)/\(rawValue)"
        } else {
            name = rawValue
        }
        return UIColor(named: name, in: Self.bundle, compatibleWith: nil)
    }
    
    /// Color to be displayed  
    var color: UIColor { loadColor() ?? Self.fallbackColor }
    
}
