//
//  InitialScreenView.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import UIKit
import Lottie

class InitialScreenView: UIView {
    
    let telescopeLottie: LottieAnimationView = LottieAnimationView.init(name: "telescope")
    let bigStarsBackgroundLottie: LottieAnimationView = LottieAnimationView.init(name: "bigStarsBackground")
    
    var didTapButton: (() -> Void)?
    var didTapSaveImageButton: (() -> Void)?
    
    var picTitle: UILabel! = UILabel() // 🤔 Does this has to be forcefully unwrapped? What is this anyway?!
    var picDate: UILabel! = UILabel()
    var picExplanation: UITextView! = UITextView()
    
    let buttonForSavingImage = UIButton()
    
    let savedCardsButton = UIButton()
    let cardView = UIView()
    let todaysPicView = UIImageView()
    let todaysPicLoadingLottie: LottieAnimationView = LottieAnimationView.init(name: "load")
    
    // ℹ️ The func below adds all views and does all settings ONLY ONCE, the first time the window appears
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // ℹ️ Colors and visual setup
        addViews()
    
        // ℹ️ Views setup
        setupCardView() // calls the func declared below
        setupSavedCardsButton()
        setupTodaysPicView()
        setupPicTitle()
        setupPicDate()
        setupPicExplanation()
        setupbigStarsBackgroundLottie()
        setuptelescopeLottie()
        setupbuttonForSavingImage()
        setuptodaysPicLoadingLottie()
    
        // ℹ️ Configs
        
        buttonForSavingImage
     .addTarget(self, action: #selector(saveImageButtonWasTapped), for: .touchUpInside)
        
        savedCardsButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside) // 💡 Added a target, goes to the func, which is declared below, and the func calls the closure
    }
    
    // ℹ️ This func adds the views created to the "parent view"
    func addViews() {
        addSubview(bigStarsBackgroundLottie)
        addSubview(cardView)
        addSubview(savedCardsButton)
        addSubview(picDate)
        addSubview(todaysPicLoadingLottie)
        addSubview(todaysPicView)
        addSubview(picTitle)
        addSubview(buttonForSavingImage)
        addSubview(picExplanation)
        addSubview(telescopeLottie)
    }

    func setuptelescopeLottie() {
//        telescopeLottie.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        telescopeLottie.play()
        telescopeLottie.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            telescopeLottie.heightAnchor.constraint(equalToConstant: 200),
            telescopeLottie.widthAnchor.constraint(equalToConstant: 200),
            telescopeLottie.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: 50),
            telescopeLottie.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 50)
        ])
    }
    
    func setuptodaysPicLoadingLottie() {
        todaysPicLoadingLottie.play()
        todaysPicLoadingLottie.translatesAutoresizingMaskIntoConstraints = false
        todaysPicLoadingLottie.loopMode = .loop
    }
    
    func setupbigStarsBackgroundLottie() {
        bigStarsBackgroundLottie.frame = CGRect(x: -30, y: 40, width: 500, height: 800)
        bigStarsBackgroundLottie.play()
        bigStarsBackgroundLottie.animationSpeed = 1 // This doesn't do anythin right now
        //        bigStarsBackgroundLottie.loopMode = .autoReverse // This doesn't do anythin right now
    }

    @objc func applicationEnterInForground() {
       
    }
    
    // ℹ️ This func is for setting up the "Cards View"
    func setupCardView() {
        
        cardView.backgroundColor = UIColor(named: "CardColor")
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false // 💡 Necessary for the constraints to work
        cardView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.68)
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
            todaysPicView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -220),

            todaysPicLoadingLottie.centerXAnchor.constraint(equalTo: todaysPicView.centerXAnchor),
            todaysPicLoadingLottie.centerYAnchor.constraint(equalTo: todaysPicView.centerYAnchor),
            todaysPicLoadingLottie.heightAnchor.constraint(equalToConstant: 150),
            todaysPicLoadingLottie.widthAnchor.constraint(equalToConstant: 150)
        ])

    }
    
    // ℹ️ The func below configures the button to save the images. The func has to come just after the button declaration, so that these lines of code actually run
    func setupbuttonForSavingImage () {
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 24, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "bookmark", withConfiguration: config)
        buttonForSavingImage
     .translatesAutoresizingMaskIntoConstraints = false
        buttonForSavingImage
     .setImage(buttonImage, for: .normal)
//        buttonForSavingImage.imageView?.tintColor = .white
//        buttonForSavingImage.imageView?.largeContentTitle = "Save Card"
                
        NSLayoutConstraint.activate([
            buttonForSavingImage
         .topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 6),
            buttonForSavingImage
         .leadingAnchor.constraint(equalTo: todaysPicView.trailingAnchor, constant: -25)
        ])
    }
    
    // ℹ️ The func below configures the savedCardsButton. The func has to come just after the button declaration, so that these lines of code actually run
    func setupSavedCardsButton() {
        
        savedCardsButton.configuration = .filled()
        savedCardsButton.configuration?.baseBackgroundColor = UIColor(named: "ButtonColor")
        savedCardsButton.setTitle("Go to my saved pics", for: .normal)
        savedCardsButton.setTitleColor(picTitle.textColor, for: .normal)
        savedCardsButton.translatesAutoresizingMaskIntoConstraints = false // 💡 Necessary for the constraints to work
        // 👨‍💻 In case I want shadow behind the button, uncomment the following lines:
//        savedCardsButton.layer.shadowColor = UIColor.systemGray.cgColor
//        savedCardsButton.layer.shadowOpacity = 0.5
//        savedCardsButton.layer.shadowOffset = .zero
//        savedCardsButton.layer.shadowRadius = 10
                
        NSLayoutConstraint.activate([
            savedCardsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            savedCardsButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            savedCardsButton.widthAnchor.constraint(equalToConstant: 200),
            savedCardsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // ℹ️ This func configures the title of the day's picture
    func setupPicTitle() {
        
        picTitle.textAlignment = .left
        picTitle.font = .preferredFont(forTextStyle: .title3).bold()
        picTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            picTitle.topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 7),
            picTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            picTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10)
        ])
    }
    
    // ℹ️ This func configures the date of the day's picture as it's displayed on the app
    func setupPicDate() {
        
    }
    
    // ℹ️ This func configures the text with the explanation of the day's picture
    func setupPicExplanation() {
        picExplanation.font = .preferredFont(forTextStyle: .body)
        picExplanation.translatesAutoresizingMaskIntoConstraints = false
        picExplanation.backgroundColor = .clear
        picExplanation.isEditable = false
        
        NSLayoutConstraint.activate([
            picExplanation.topAnchor.constraint(equalTo: picTitle.bottomAnchor, constant: 7),
            picExplanation.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            picExplanation.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            picExplanation.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func saveImageButtonWasTapped() {
        didTapSaveImageButton?()
    }
    
    @objc func buttonWasTapped() {
        didTapButton?()
    }
    
    // 👨‍💻 Piece of code for creating a Lottie Animation in a different way than the one used in this project:
//    let todaysPlaceHolder: LottieAnimationView = {
//        let animation = LottieAnimationView(name: "load")
//        animation.translatesAutoresizingMaskIntoConstraints = false
//        animation.loopMode = .loop
//        return animation
//    }()
    
    // 👨‍💻 Piece of code for creating a standard loading animation and stop using a lottie (I'll do this later)
//    let userActiviyt: UIActivityIndicatorView = {
//        let loading = UIActivityIndicatorView()
//        loading.style = .medium
//        loading.startAnimating()
//        loading.translatesAutoresizingMaskIntoConstraints = false
//
//        return loading
//    }()
    
    // 👨‍💻 Use the func below in place of didMoveToWindow() when I need to use some code that needs the constraints applied
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }

}

