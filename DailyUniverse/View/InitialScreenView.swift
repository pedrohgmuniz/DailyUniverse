//
//  InitialScreenView.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import UIKit
import Lottie
import WebKit

class InitialScreenView: UIView {
    
    // ℹ️ Lottie animations
    let telescopeLottie: LottieAnimationView = LottieAnimationView.init(name: "telescope")
    let bigStarsBackgroundLottie: LottieAnimationView = LottieAnimationView.init(name: "bigStarsBackground")
    let todaysPicLoadingLottie: LottieAnimationView = LottieAnimationView.init(name: "load")
    
    // ℹ️ Textual elements
    var picTitle: UILabel! = UILabel() // 🤔 Y is this forcefully unwrapped?
    var picDate: UILabel! = UILabel()
    var picExplanation: UITextView! = UITextView()
    
    // ℹ️ Buttons
    let savedCardsButton = UIButton()
    let buttonForSavingImage = UIButton()
    let buttonForSharingContent = UIButton()
    var didTapButton: (() -> Void)?
//    var didTapSaveImageButton: (() -> Void)?
//    var didTapSharingButton: (() -> Void)?
    
    // ℹ️ Image and other Views
    let cardView = UIView()
    let todaysPicView = UIImageView()
    
    // ℹ️ View for the video of the day, whenever there's a video
    let videoOfTheDay: WKWebView = {
        let myWKWebViewConfig = WKWebViewConfiguration()
        myWKWebViewConfig.allowsInlineMediaPlayback = true
        let videoOfTheDay = WKWebView(frame: .zero, configuration: myWKWebViewConfig)
        videoOfTheDay.translatesAutoresizingMaskIntoConstraints = false
        return videoOfTheDay
    }()
    
    let sharedItems: [Any] = []
//    let ac = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
//    present(ac, animated: true)
    
    
    // *********************** GENERAL SETUP ***********************
    // ℹ️ The func below adds all views and does all settings as the window appears
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        addViews()
    
        // ℹ️ Views setup functions
        setupCardView() // calls the func declared below
        setupSavedCardsButton()
        setupTodaysPicView()
        setupPicTitle()
        setupPicDate()
        setupPicExplanation()
        setupbigStarsBackgroundLottie()
        setuptelescopeLottie()
        setupbuttonForSharingContent()
        setupbuttonForSavingImage()
        setuptodaysPicLoadingLottie()
        setupvideoOfTheDay()
    
        buttonForSharingContent.addTarget(self, action: #selector(sharingButtonWasTapped), for: .touchUpInside)
        
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
        addSubview(buttonForSharingContent)
        addSubview(buttonForSavingImage)
        addSubview(picExplanation)
        addSubview(telescopeLottie)
        addSubview(videoOfTheDay)
    }

    
    // *********************** LOTTIE ANIMATIONS ***********************
    func setuptelescopeLottie() {
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
        bigStarsBackgroundLottie.animationSpeed = 1
    }
    
    
    // *********************** TEXTUAL ELEMENTS ***********************
    // ℹ️ This func configures the title of the day's picture
    func setupPicTitle() {
        
        picTitle.textAlignment = .left
        picTitle.font = .preferredFont(forTextStyle: .body).bold().withSize(18)
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
    
    
    // *********************** IMAGE AND OTHER VIEWS ***********************
    // ℹ️ This func congigures the "Card View" that holds the image, textual elements and buttons for saving and sharing
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
    
    // ℹ️ This func configures the "Day's picture View" that goes inside the card
    func setupTodaysPicView(){

        todaysPicView.contentMode = .scaleAspectFill
        todaysPicView.clipsToBounds = true
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

    // ℹ️ This func configures the "Day's picture View" that goes inside the card
    func setupvideoOfTheDay(){

        videoOfTheDay.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            videoOfTheDay.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            videoOfTheDay.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            videoOfTheDay.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            videoOfTheDay.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -220),

//            videoOfTheDay.centerXAnchor.constraint(equalTo: todaysPicView.centerXAnchor),
//            videoOfTheDay.centerYAnchor.constraint(equalTo: todaysPicView.centerYAnchor),
//            videoOfTheDay.heightAnchor.constraint(equalToConstant: 150),
//            videoOfTheDay.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    func playURLVideo(url: URL) {
        
        
    }
    
    // *********************** BUTTONS ***********************
    // ℹ️ This func configures the button for sharing the cards' contents
    func setupbuttonForSharingContent() {
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        buttonForSharingContent
     .translatesAutoresizingMaskIntoConstraints = false
        buttonForSharingContent
     .setImage(buttonImage, for: .normal)
                
        NSLayoutConstraint.activate([
            buttonForSharingContent
         .topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 6),
            buttonForSharingContent
                .leadingAnchor.constraint(equalTo: buttonForSavingImage.leadingAnchor, constant: -28),
        ])
    }
    
    // ℹ️ Func that configures the button to save the cards to your Saved Pics Screen on the app
    func setupbuttonForSavingImage () {
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .medium, scale: .default)
        let buttonImage = UIImage(systemName: "bookmark", withConfiguration: config)
        buttonForSavingImage
     .translatesAutoresizingMaskIntoConstraints = false
        buttonForSavingImage
     .setImage(buttonImage, for: .normal)
                
        NSLayoutConstraint.activate([
            buttonForSavingImage
         .topAnchor.constraint(equalTo: todaysPicView.bottomAnchor, constant: 6),
            buttonForSavingImage
         .leadingAnchor.constraint(equalTo: todaysPicView.trailingAnchor, constant: -18)
        ])
    }
    
    // ℹ️ Func that configures the button to access the Saved Pics Screen
    func setupSavedCardsButton() {
        
        savedCardsButton.configuration = .filled()
        savedCardsButton.configuration?.cornerStyle = .capsule
        savedCardsButton.configuration?.baseBackgroundColor = UIColor(named: "ButtonColor")
        savedCardsButton.setTitle("Go to my saved pics", for: .normal)
        savedCardsButton.setTitleColor(picTitle.textColor, for: .normal)
        savedCardsButton.translatesAutoresizingMaskIntoConstraints = false // 💡 Necessary for the constraints to work
    // 👨‍💻 In case I want to insert shadow behind the button, uncomment the following lines:
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

    
    // *********************** BUTTONS FUNCS ***********************
    // 💡 The buttons will execute the code inside these:
    @objc func saveImageButtonWasTapped() {
//        didTapSaveImageButton?()
    }
    
    @objc func sharingButtonWasTapped() {
        
    }
    
    @objc func buttonWasTapped() {
        didTapButton?()
    }
    
//    @objc func applicationEnterInForground() {
//
//    }
    
//  // 👨‍💻 Piece of code for creating a Lottie Animation in a different way than the one used in this project:
//    let todaysPlaceHolder: LottieAnimationView = {
//        let animation = LottieAnimationView(name: "load")
//        animation.translatesAutoresizingMaskIntoConstraints = false
//        animation.loopMode = .loop
//        return animation
//    }()
    
//  // 👨‍💻 Piece of code for creating a standard loading animation and stop using a lottie (I'll do this later)
//    let userActiviyt: UIActivityIndicatorView = {
//        let loading = UIActivityIndicatorView()
//        loading.style = .medium
//        loading.startAnimating()
//        loading.translatesAutoresizingMaskIntoConstraints = false
//
//        return loading
//    }()
    
//  // 👨‍💻 Use the func below in place of didMoveToWindow() when I need to use some code that needs the constraints applied
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }

}
