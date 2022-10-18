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
        title = "My Saved Pictures"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
}
