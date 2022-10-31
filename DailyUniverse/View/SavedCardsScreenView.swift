//
//  SavedCardsScreenView.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import UIKit
import Lottie

class SavedCardsScreenView: UIView {
    
    let lottie2: LottieAnimationView = LottieAnimationView.init(name: "bigStarsBackground")
    
    override func layoutSubviews() {
        super.layoutSubviews() // 💡 This calls the "parent" method
//        backgroundColor = .purple
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        addSubview(lottie2)
        
        setupLottieAnimation2()
    }
    
    func setupLottieAnimation2() {
//        lottie2.loopMode = .loop
        lottie2.frame = CGRect(x: -30, y: 40, width: 500, height: 800)
        lottie2.play() 
        lottie2.animationSpeed = 1 // This doesn't do anythin right now
//        lottie2.loopMode = .autoReverse // This doesn't do anythin right now
    }
    
}
