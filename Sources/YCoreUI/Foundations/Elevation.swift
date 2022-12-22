//
//  Elevation.swift
//  YCoreUI
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

/// Encapsulates design shadows and applies them to a layer.
///
/// This data structure is designed to closely match how shadows are exported from Figma
/// and also how they are specified for web/CSS.
/// cf. https://www.w3.org/TR/css-backgrounds-3/#box-shadow
public struct Elevation: Equatable {
    /// Specifies the horizontal offset of the shadow.
    ///
    /// A positive value draws a shadow that is offset to the right of the box, a negative length to the left.
    public let xOffset: CGFloat

    /// Specifies the vertical offset of the shadow.
    ///
    /// A positive value offsets the shadow down, a negative one up.
    public let yOffset: CGFloat

    /// Specifies the blur radius.
    ///
    /// Negative values are invalid. If the blur value is zero, the shadow’s edge is sharp.
    /// Otherwise, the larger the value, the more the shadow’s edge is blurred
    public let blur: CGFloat

    /// Specifies the spread distance.
    ///
    /// Positive values cause the shadow to expand in all directions by the specified radius.
    /// Negative values cause the shadow to contract.
    public let spread: CGFloat

    /// Specifies the color of the shadow.
    ///
    /// This value should be opaque (i.e. alpha channel = 1.0 or 0xFF). `opacity` is a separate property.
    public let color: UIColor

    /// Specifies the opacity of the shadow.
    ///
    /// Possible values range from `0.0` to `1.0` (inclusive). `0` means no shadow, and `1` means fully opaque.
    public let opacity: Float

    /// Whether `apply(layer:cornerRadius:)` should set the shadowPath. Defaults to `true`.
    ///
    /// Should be `false` for layers that are not a simple rect or round-rect
    /// (e.g. ellipse, circle, donut, or other irregular shape such as a logo).
    /// Note that when `false` the `spread` property is ignored.
    /// Image rendering performance will be better when set to `true` (avoids an off-screen render pass).
    public let useShadowPath: Bool
    
    /// Initializes an elevation
    /// - Parameters:
    ///   - xOffset: the horizontal offset of the shadow
    ///   - yOffset: the vertical offset of the shadow
    ///   - blur: the blur radius
    ///   - spread: the spread distance
    ///   - color: the color of the shadow
    ///   - opacity: the opacity of the shadow
    ///   - useShadowPath: whether to set the shadowPath. Default is `true`
    public init(
        xOffset: CGFloat,
        yOffset: CGFloat,
        blur: CGFloat,
        spread: CGFloat,
        color: UIColor,
        opacity: Float,
        useShadowPath: Bool = true
    ) {
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.blur = max(blur, 0)
        self.spread = spread
        self.color = color
        self.opacity = max(min(opacity, 1), 0)
        self.useShadowPath = useShadowPath
    }

    /// Computes how far from the edges of the view the shadow will extend in each direction.
    ///
    /// This is determined by offset, blur, and spread, but not by opacity (unless zero).
    /// The rectangle enclosing the shadow should be the view's frame outset by `extent`.
    public var extent: UIEdgeInsets {
        guard opacity > 0 else { return .zero }

        return UIEdgeInsets(
            top: blur + spread - yOffset,
            left: blur + spread - xOffset,
            bottom: blur + spread + yOffset,
            right: blur + spread + xOffset
        )
    }
    /// Applies elevation to a layer.
    ///
    /// In most cases `cornerRadius` should match `layer.cornerRadius`.
    /// Note: This method does not set `layer.cornerRadius`, only the layer's shadow properties.
    /// - Parameters:
    ///   - layer: the layer to apply the elevation to.
    ///   - cornerRadius: the corner radius to use for the shadow path.
    ///   Pass `nil` to use `layer.cornerRadius` (the default).
    ///   Ignored when `useShadowPath == false`
    public func apply(layer: CALayer, cornerRadius: CGFloat? = nil) {
        applyShadow(layer: layer)
        
        if useShadowPath {
            // inset the rect by the spread distance
            let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
            var radius = cornerRadius ?? layer.cornerRadius
            if radius > 0 {
                // for rounded rects, we need to increase the corner radius by the spread distance
                // (but we floor to 0)
                radius = max(radius + spread, 0)
            }
            layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        }
    }
    
    private func applyShadow(layer: CALayer) {
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
        layer.shadowRadius = blur / 2.5
    }
}
