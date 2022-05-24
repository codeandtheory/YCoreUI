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
    /// - Parameter bundle: the bundle containing the localized string resource to use. Default = main app bundle.
    /// - Returns: the localized string or else itself if it is not localized.
    func localized(bundle: Bundle = .main) -> String {
        NSLocalizedString(self, bundle: bundle, comment: self)
    }
}
