//
//  InitialScreen.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 10/10/22.
//

import UIKit
import Lottie

class InitialScreenViewController: UIViewController {
    
    // Model (instance of the Model struct here in the Controller)
    var post: Post? {
        didSet {
            DispatchQueue.main.async {
                self.contentView.picTitle.text = self.post?.title ?? "" // setting defaulf "" values in case sth goes amiss
                self.contentView.picDate.text = self.post?.date ?? ""
                self.contentView.picExplanation.text = self.post?.explanation ?? ""
            }
        }
    }
    
    var image: UIImage? {
        didSet { // Every time a new value gets here, the code below is run
            DispatchQueue.main.async {
                self.contentView.todaysPicView.image = self.image
            }
        }
    }
    
    // View (instance of the View here in the Controller)
    let contentView = InitialScreenView()

    // Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad() // Does any additional setup after loading the view.

        title = "Picture of the Day"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contentView.didTapButton = {
            self.goToSavedCardsScreen()
        }
        
        makeRequest()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    // Refactor this to be in an API layer/service
    private func makeRequest() {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=wecxoRe6g4DvX2KBDWxsCOQmtQJABHGjilEutoZB")!
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in
                print("response: \(String(describing: response))")
                print("error: \(String(describing: error))")
                
                guard let responseData = data else { return }
                
                do {
                    let post = try JSONDecoder().decode(Post.self, from: responseData)
                    self.post = post
                    
                    if let url = URL(string: post.hdurl) {
                        self.makeRequestOfImage(url: url)
                    }
                    
                    print("objects returned: \(post)")
                } catch let error {
                    print("error: \(error)")
                }
            }
        )

        task.resume()
    }
    
    // Refactor this to be in a API layer/service
    private func makeRequestOfImage(url: URL) {
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in
                print("response: \(String(describing: response))")
                print("error: \(String(describing: error))")
                
                guard let responseData = data else { return }
                
                let todaysPic = UIImage.init(data: responseData)
                print(todaysPic!)
                self.image = todaysPic
            }
        )

        task.resume()
    }

    // Navigation function
    func goToSavedCardsScreen() {
        let secondScreen = SavedCardsScreenViewController() // creates the view
        navigationController?.pushViewController(secondScreen, animated: true) // takes care of the navigation
    }
    
}

