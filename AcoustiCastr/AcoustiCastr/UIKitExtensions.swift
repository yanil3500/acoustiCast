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
    
    //Courtesy of user Leo Dabus on Stackoverflow
//    class func downloadedFrom(urlFrom: String) {
//        guard let imageUrl = URL(string: urlFrom) else { print("Failed to get Image URL");return }
//        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
//            if error != nil {
//                print("Here is the error code and response. \(error)")
//                return;
//            }
//            guard let imageData = data else { fatalError("Failed to get image data"); return }
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }.resume()
//
//    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloadedFrom(url: url, contentMode: mode)
//    }

}




//Gives global identifier to any class that conforms to UIResponder (all views conform to the UI responder)
//Useful in situations dealing with segues identifiers
extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
