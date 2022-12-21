//
//  ImageAsset.swift
//  YCoreUI
//
//  Created by Dev Karan on 19/12/22.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageAsset {
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
}
