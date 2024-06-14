//
//  UIView+Transform.swift
//  InstaReactionInteraction-iOS
//
//  Created by Artem Zabihailo on 14.06.2024.
//

import UIKit

extension UIView {
    
    func applyPinTransform(
        scale: CGFloat,
        point scaleAnchorPoint: CGPoint = CGPoint(x: 0.1, y: 0.5)
    ) {
        layer.anchorPoint = scaleAnchorPoint
        
        let scale = scale != 0 ? scale : Double.leastNormalMagnitude
        let xPadding = 1 / scale * (anchorPoint.x - 0.7) * bounds.width
        let yPadding = 1 / scale * (anchorPoint.y - 0.6) * bounds.height
        
        transform = CGAffineTransform(scaleX: scale, y: scale)
            .translatedBy(x: xPadding, y: yPadding)
            .translatedBy(
                x: bounds.height / 2,
                y: -bounds.height / 2
            )
    }
    
}
