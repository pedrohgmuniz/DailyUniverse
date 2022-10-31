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
                //Removendo o loading animation depois que a imagem chegar da API
                self.contentView.todaysPicLoadingLottie.removeFromSuperview()
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
        setBackgroundColor()
        
//        self.setupAnimation()
//        NotificationCenter.default.addObserver(self, selector: #selector(applicationEnterInForground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        title = "Picture of the Day"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contentView.didTapButton = {
            self.goToSavedCardsScreen()
        }
        
        api.makeRequest { post in
            self.post = post
            
            if post.media_type == "image" {
                if let url = URL(string: post.hdurl) {
                    self.api.makeRequestOfImage(url: url) { image in
                        self.image = image
                    }
                }
            } else {
                // what the video does
            }
        }
        
    }
    
    // 💡 This func makes the image request from the API to run everytime the user goes to another screen and comes back <- Need to find a better solution
    override func viewWillAppear(_ animated: Bool) {
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
            UIColor(named: "UpGradient")!.cgColor,
            UIColor(named: "DownGradient")!.cgColor
        )
    }
    
}

