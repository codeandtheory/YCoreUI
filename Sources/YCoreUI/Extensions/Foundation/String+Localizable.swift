//
//  String+Localizable.swift
//  YCoreUI
//
//  Created by Mark Pospesel on 11/10/21.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import Foundation

public extension String {
    /// Gets a localized string resource using the string's current value as key
    /// - Parameters:
    ///   - bundle: the bundle containing the localized string resource to use. Default = main app bundle.
    ///   - tableName: the name of the `.strings` file containing the localized strings for this enum.
    /// - Returns: the localized string or else itself if it is not localized.
    func localized(bundle: Bundle = .main, tableName: String? = nil) -> String {
        NSLocalizedString(self, tableName: tableName, bundle: bundle, comment: self)
    }
}
