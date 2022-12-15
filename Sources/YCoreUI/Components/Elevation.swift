//
//  Elevation.swift
//  YCoreUI
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

/// Encapsulate design shadows and apply them to view.
public struct Elevation {
    /// The offset of the layer’s shadow.
    public let offset: CGSize
    /// The blur of the layer's. shadow.
    public let blur: CGFloat
    /// The spread of the layer's. shadow.
    public let spread: CGFloat
    /// The color of the layer’s shadow.
    public let color: UIColor
    /// The opacity of the layer’s shadow.
    public let opacity: Float
    /// Flag to set shadow path. Default is `true`.
    public let useShadowPath: Bool
    
    /// Initializes `Elevation`.
    /// - Parameters:
    ///   - offset: the offset of the layer’s shadow
    ///   - blur: the blur of the layer's shadow
    ///   - spread: the spread of the layer's. shadow
    ///   - color: the color of the layer’s shadow
    ///   - opacity: the opacity of the layer’s shadow
    ///   - useShadowPath: flag to set shadow path. Default is `true`
    public init(
        offset: CGSize,
        blur: CGFloat,
        spread: CGFloat,
        color: UIColor,
        opacity: Float,
        useShadowPath: Bool = true
    ) {
        self.offset = offset
        self.blur = blur
        self.spread = spread
        self.color = color
        self.opacity = opacity
        self.useShadowPath = useShadowPath
    }
    
    /// Applies elevation to a layer.
    /// - Parameters:
    ///   - layer: layer of the corresponding view
    ///   - cornerRadius: the radius to use when drawing rounded corners for the layer’s background.
    public func apply(layer: CALayer, cornerRadius: CGFloat) {
        applyShadow(layer: layer)
        
        if useShadowPath {
            let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
            layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
    }
    
    private func applyShadow(layer: CALayer) {
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = blur / 2
    }
}
