//
//  InitialScreen.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 10/10/22.
//

import UIKit
import Lottie

class InitialScreenViewController: UIViewController {
    
    // ℹ️ Model (instance of the Model struct here in the Controller)
    var post: Post? {
        didSet {
            DispatchQueue.main.async {
                self.contentView.picTitle.text = self.post?.title ?? "" // 💡 Set defaulf "" values here in case something goes amiss
                self.contentView.picDate.text = self.post?.date ?? ""
                self.contentView.picExplanation.text = self.post?.explanation ?? ""
            }
        }
    }
    
    var image: UIImage? {
        didSet { // 💡 Every time a new value gets here, the code below is run
            DispatchQueue.main.async {
                self.contentView.todaysPicView.image = self.image
            }
        }
    }
    
    // ℹ️ View (instance of the View here in the Controller)
    let contentView = InitialScreenView()
    
    // ℹ️ API (instance of the API here in the Controller)
    let api: API = API()

    // ℹ️ Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad() // 💡 Does any additional setup after loading the view.

        title = "Picture of the Day"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contentView.didTapButton = {
            self.goToSavedCardsScreen()
        }
        
        api.makeRequest { post in
            self.post = post
            
            if let url = URL(string: post.hdurl) {
                self.api.makeRequestOfImage(url: url) { image in
                    self.image = image
                }
            }
        }
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }

    // ℹ️ Navigation function
    func goToSavedCardsScreen() {
        let secondScreen = SavedCardsScreenViewController() // 💡 This creates the view
        navigationController?.pushViewController(secondScreen, animated: true) // 💡 This takes care of the navigation
    }
    
}

