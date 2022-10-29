//
//  CAGradientLayer+ListStyle.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 26/10/22.
//  ℹ️ This file takes care of the gradient colors of the app's background. According to https://developer.apple.com/tutorials/app-dev-training/creating-a-gradient-background it should be in the Models group

import Foundation
import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    
    // ℹ️ This func accepts a list stule and returns an array of colors
    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        let beginColor: UIColor // 💡 These constants define the starting and ending colors for the gradient stops
        let endColor: UIColor
        
        switch style {
        case .all:
            beginColor = .todayGradientAllBegin
            endColor = .todayGradientAllEnd
        case .future:
            beginColor = .todayGradientFutureBegin
            endColor = .todayGradientFutureEnd
        case .today:
            beginColor = .todayGradientTodayBegin
            endColor = .todayGradientTodayEnd
        }
        return [beginColor.cgColor, endColor.cgColor]

    }
}
    

