//
//  File.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 26/10/22.
//

import Foundation
import UIKit

extension CALayer {
    public func configureGradientBackground(_ colors:CGColor...) {
        if let gradient = sublayers?.first as? CAGradientLayer {
            gradient.colors = colors
            return
        }
        let gradient = CAGradientLayer()
        let maxWidth = max(
            self.bounds.size.height,
            self.bounds.size.width
        )
        let squareFrame = CGRect(
            origin: self.bounds.origin,
            size: CGSize(width: maxWidth, height: maxWidth)
        )
        gradient.frame = squareFrame
        gradient.colors = colors
        self.addSublayer(gradient)
    }
}
