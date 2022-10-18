//
//  InitialScreenView.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 17/10/22.
//

import UIKit

class InitialScreenView: UIView {
    
    var didTapButton: (() -> Void)? // this is a closure
    
    let savedCardsButton = UIButton()
    let cardView = UIView()
    let todaysPicView = UIImageView()
    
    // The func below adds all views and does all settings ONLY ONCE, the first time the window appears
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // colors and visual setup
        backgroundColor = .purple
        addViews()
    
        // views setup
        setupCardView() // calls the func declared below
        setupSavedCardsButton()
        setupTodaysPicView()
    
        // configs
        savedCardsButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside) // added a target, goes to the func, which is declared below, and the func calls the closure
    }
    
// Use the func bwelow in place of didMoveToWindow() when I need to use some code that needs the constraints applied
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
    func addViews() {
        addSubview(cardView) // adds the view created to the "father view"
        addSubview(savedCardsButton)
        addSubview(todaysPicView)
    }

    // this function is for setting up the cards view
    func setupCardView() {
        
        cardView.backgroundColor = .white
        cardView.translatesAutoresizingMaskIntoConstraints = false // necessary for the constraints to work
        cardView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
    }
    
    // This func sets up the daily picture view that'll go inside the card
    func setupTodaysPicView(){

        todaysPicView.translatesAutoresizingMaskIntoConstraints = false
        todaysPicView.image = UIImage(systemName: "star.fill")
        todaysPicView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            todaysPicView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            todaysPicView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            todaysPicView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            todaysPicView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10)
        ])

    }
    
    // The func below configures the savedCardsButton. It has to come just after the button declaration, so that these lines of code actually run
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
    
    @objc func buttonWasTapped() {
        didTapButton?()
    }

}

