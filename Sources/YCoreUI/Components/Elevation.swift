//
//  Elevation.swift
//  YCoreUI
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

public struct Elevation {
    public let offset: CGSize
    public let blur: CGFloat
    public let spread: CGFloat
    public let color: UIColor
    public let opacity: CGFloat
    public let useShadowPath: Bool
    
    public init(
        offset: CGSize,
        blur: CGFloat,
        spread: CGFloat,
        color: UIColor,
        opacity: CGFloat,
        useShadowPath: Bool = true
    ) {
        self.offset = offset
        self.blur = blur
        self.spread = spread
        self.color = color
        self.opacity = opacity
        self.useShadowPath = useShadowPath
    }
    
    public func apply(layer: CALayer, cornerRadius: CGFloat) {
        guard useShadowPath else { return }
        
        let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
    }
}
