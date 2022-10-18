//
//  InitialScreen.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 10/10/22.
//

import UIKit
import Lottie

class InitialScreenViewController: UIViewController {
    
    var post: Post?
    var image: UIImage? {
        didSet { // every time a new value gets here, the code below is run
            DispatchQueue.main.async {
                //self.contentView.cardView.imageView.image = self.image
            }
        }
    }
    
    let contentView = InitialScreenView()

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
    
    // It would be cool to refactor this to be in a API layer/service
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
    
    // It would be cool to refactor this to be in a API layer/service
    private func makeRequestOfImage(url: URL) {
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in
                print("response: \(String(describing: response))")
                print("error: \(String(describing: error))")
                
                guard let responseData = data else { return }
                
                let todaysPic = UIImage.init(data: responseData)
                print(todaysPic)
                self.image = todaysPic
            }
        )

        task.resume()
    }

    func goToSavedCardsScreen() {
        let secondScreen = SavedCardsScreenViewController() // creates the view
        navigationController?.pushViewController(secondScreen, animated: true) // takes care of the navigation
    }
    
}

