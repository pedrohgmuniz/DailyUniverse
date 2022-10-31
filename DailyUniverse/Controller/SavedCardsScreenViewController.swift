//
//  SavedCardsScreen.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 14/10/22.
//

import UIKit

class SavedCardsScreenViewController: UIViewController {
    
    let contentView = SavedCardsScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Saved Pictures  💾"
        navigationController?.navigationBar.prefersLargeTitles = true
        setBackgroundColor()

    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    // ℹ️ Functions for taking care of the degrade background
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.sublayers?.first?.frame = view.bounds
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super
            .traitCollectionDidChange(previousTraitCollection)
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        view.layer.configureGradientBackground(
            UIColor(named: "SavedCardsUpGradient")!.cgColor,
            UIColor(named: "SavedCardsDownGradient")!.cgColor
        )
    }
    
}
