//
//  InitialScreenView.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import UIKit
import Lottie

class InitialScreenView: UIView {
    
    let lottie: LottieAnimationView = LottieAnimationView.init(name: "starfall")
    var didTapButton: (() -> Void)? // 💡 This is a closure
    
    // 💡 This takes care of the gradient background
    let gradientLayer = CAGradientLayer()
//    gradientLayer.frame: view.bounds
//    gradientLayer.colors: []
    
    var picTitle: UILabel! = UILabel() // 🤔 Does this has to be forcefully unwrapped? What is this anyway?!
    var picDate: UILabel! = UILabel()
    var picExplanation: UITextView! = UITextView()
    
    let ButtonForSavingImage = UIButton()
    
    let savedCardsButton = UIButton()
    let cardView = UIView()
    let todaysPicView = UIImageView()
    let todaysPlaceHolder: LottieAnimationView = {
        let animation = LottieAnimationView(name: "load")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .loop
        return animation
    }()
    
    // ℹ️ The func below adds all views and does all settings ONLY ONCE, the first time the window appears
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        
        // ℹ️ Colors and visual setup
        backgroundColor = .purple
        addViews()
    
        // ℹ️ Views setup
        setupCardView() // calls the func declared below
        setupSavedCardsButton()
        setupTodaysPicView()
        setupPicTitle()
        setupPicDate()
        setupPicExplanation()
        setupAnimation()
    
        // ℹ️ Configs
        savedCardsButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside) // 💡 Added a target, goes to the func, which is declared below, and the func calls the closure
    }
    
// Use the func below in place of didMoveToWindow() when I need to use some code that needs the constraints applied
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    // ℹ️ This func adds the views created to the "parent view"
    func addViews() {
        addSubview(lottie)
        addSubview(cardView)
        addSubview(savedCardsButton)
        addSubview(todaysPlaceHolder)
        addSubview(todaysPicView)
        addSubview(picTitle)
        addSubview(picDate)
        addSubview(picExplanation)
    }

    func setupAnimation() {
        lottie.loopMode = .loop
        lottie.frame = CGRect(x: -110, y: 0, width: 600, height: 400)
//        lottie.frame.size = CGSize(width: 400, height: 700)
//        lottie.anchorPoint = CGPoint(x: 0, y: 100)
        lottie.play()
        todaysPlaceHolder.play()
        
//        lottie.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            lottie.topAnchor.constraint(equalTo: self.topAnchor),
//            lottie.leftAnchor.constraint(equalTo: self.leftAnchor),
//            lottie.rightAnchor.constraint(equalTo: self.rightAnchor),
//            lottie.heightAnchor.constraint(equalTo: self.heightAnchor)
//        ])
    }

    @objc func applicationEnterInForground() {
       
    }
    
    // ℹ️ This func is for setting up the "Cards View"
    func setupCardView() {
        
        cardView.backgroundColor = .white
        cardView.translatesAutoresizingMaskIntoConstraints = false // 💡 Necessary for the constraints to work
        cardView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65)
        ])
    }
    
    // ℹ️ This func sets up the "Daily picture View" that goes inside the card
    func setupTodaysPicView(){

        todaysPicView.layer.cornerRadius = 10
        todaysPicView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            todaysPicView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            todaysPicView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            todaysPicView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            todaysPicView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -200),

            todaysPlaceHolder.centerXAnchor.constraint(equalTo: todaysPicView.centerXAnchor),
            todaysPlaceHolder.centerYAnchor.constraint(equalTo: todaysPicView.centerYAnchor),
            todaysPlaceHolder.heightAnchor.constraint(equalToConstant: 150),
            todaysPlaceHolder.widthAnchor.constraint(equalToConstant: 150 )
        ])

    }
    
    // ℹ️ The func below configures the button to save the images. The func has to come just after the button declaration, so that these lines of code actually run
    func setupSavePicsButton() {
        
        ButtonForSavingImage.translatesAutoresizingMaskIntoConstraints = false
        ButtonForSavingImage.setImage(UIImage(systemName: "bookmark"), for: .normal)
                
        NSLayoutConstraint.activate([
            ButtonForSavingImage.topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 7),
      //      savePicButton.trailingAnchor.constraint(equalTo: todaysPicView., constant: -40)
        ])
    }
    
    // ℹ️ The func below configures the savedCardsButton. The func has to come just after the button declaration, so that these lines of code actually run
    func setupSavedCardsButton() {
        
        savedCardsButton.configuration = .filled()
        savedCardsButton.configuration?.baseBackgroundColor = .black
        savedCardsButton.configuration?.title = "Go to my saved pics"
        savedCardsButton.translatesAutoresizingMaskIntoConstraints = false // necessary for the constraints to work
                
        NSLayoutConstraint.activate([
            savedCardsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            savedCardsButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            savedCardsButton.widthAnchor.constraint(equalToConstant: 200),
            savedCardsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // ℹ️ This func configures the title of the day's picture
    func setupPicTitle() {
        
        picTitle.textAlignment = .center
        picTitle.font = .systemFont(ofSize: 16, weight: .heavy)
        picTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picTitle.topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 7),
            picTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            picTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10)
        ])
    }
    
    // ℹ️ This func configures the date of the day's picture as it's displayed on the app
    func setupPicDate() {
        
    }
    
    // ℹ️ This func configures the text with the explanation of the day's picture
    func setupPicExplanation() {
        
        picExplanation.font = .systemFont(ofSize: 15)
        picExplanation.translatesAutoresizingMaskIntoConstraints = false
        picExplanation.isEditable = false
        
        NSLayoutConstraint.activate([
            picExplanation.topAnchor.constraint(equalTo: picTitle.bottomAnchor, constant: 7),
            picExplanation.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            picExplanation.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            picExplanation.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func buttonWasTapped() {
        didTapButton?()
    }

}

