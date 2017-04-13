//
//  UIKitExtensions.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/10/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit


extension UIImage {
    
    func resize(size: CGSize) -> UIImage? {
        
        //Creates a graphics context
        UIGraphicsBeginImageContext(size)
        
        //Self is an instance of UIImage
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        //UIGraphicsGetImageFromCurrentImageContext() gets the image from the self.draw
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
extension UIImage {
    typealias ImageCallback = (UIImage?)->()
    
    class func fetchImageWith(_ urlString: String, callback: @escaping ImageCallback){
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { callback(nil); return }
            
            //Optional try, so that if Data(contentsOf:) fails, nil gets assigned into data
            if let data = try? Data(contentsOf: url) {
                
                guard let image = UIImage(data: data) else { fatalError("Image not found")}
                OperationQueue.main.addOperation {
                    callback(image)
                }
            } else {
                OperationQueue.main.addOperation {
                    callback(nil)
                }
            }
            
        }
    }
    
    typealias podcastsWithImageCallback = ([Podcast]?)->()
    
    class func fetchImageWith(_ podcasts: [Podcast], completion: @escaping podcastsWithImageCallback){
        var podcastsWithImages = [Podcast]()
        OperationQueue().addOperation {
            for pod in podcasts {
                guard let url = URL(string: pod.podcastArt as! String) else { completion(nil); return }
                //Optional try, so that if Data(contentsOf:) fails, nil gets assigned into data
                if let data = try? Data(contentsOf: url) {
                    guard let image = UIImage(data: data) else { fatalError("Image not found")}
                    pod.podcastArt = image
                    podcastsWithImages.append(pod)
                } else {
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                }
            }
            OperationQueue.main.addOperation {
                completion(podcastsWithImages)
            }
        }
    }
}




//Gives global identifier to any class that conforms to UIResponder (all views conform to the UI responder)
//Useful in situations dealing with segues identifiers
extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
