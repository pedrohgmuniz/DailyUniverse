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
    
    let cardView = UIView() //
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        // colors and visual setup
        backgroundColor = .purple
        addViews()
    
        // views setup
        setupCardView() // calls the func declared below
        setupSavedCardsButton()
    
        // configs
        savedCardsButton.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside) // added a target, goes to the func, which is declared below, and the func calls the closure
    }
    
    func addViews() {
        addSubview(cardView) // adds the view created to the "father view"
        addSubview(savedCardsButton)
    }

    // this function is for setting up the view
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

