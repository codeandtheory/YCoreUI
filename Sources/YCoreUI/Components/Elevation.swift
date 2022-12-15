//
//  Elevation.swift
//  YCoreUI
//
//  Created by Karthik K Manoj on 14/12/22.
//  Copyright © 2021 Y Media Labs. All rights reserved.
//

import UIKit

struct Elevation {
    let offset: CGSize
    let blur: CGFloat
    let spread: CGFloat
    let color: UIColor
    let opacity: CGFloat
    let useShadowPath: Bool
    
    init(
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
    
    func apply(layer: CALayer, cornerRadius: CGFloat) {
        guard useShadowPath else { return }
        
        let rect = layer.bounds.insetBy(dx: -spread, dy: -spread)
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
    }
}
