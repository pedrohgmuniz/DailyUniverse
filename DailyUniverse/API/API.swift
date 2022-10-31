//
//  File.swift
//  DailyUniverse
//
//  Created by Pedro Muniz on 24/10/22.
//

import Foundation
import UIKit

class API {
    
    //    let urlVideoOrImage = media_type

    //enum VideoOrImage: String, Codable {
    //    case video
    //    case image
    //}
    
    func makeRequest(completion: @escaping (Post) -> Void) {
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=wecxoRe6g4DvX2KBDWxsCOQmtQJABHGjilEutoZB")!
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in
//                print("response: \(String(describing: response))")
//                print("error: \(String(describing: error))")
                
                guard let responseData = data else { return }
                
                do {
                    let post = try JSONDecoder().decode(Post.self, from: responseData)
                    completion(post)
                    
//                    print("objects returned: \(post)")
                } catch let error {
                    print("error: \(error)")
                }
            }
        )

        task.resume()
    }

    func makeRequestOfImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(
            with: url,
            completionHandler: { (data, response, error) in

                guard let responseData = data else { return }
                
                let todaysPic = UIImage.init(data: responseData)
                completion(todaysPic)
            }
        )
        task.resume()
    }
}


