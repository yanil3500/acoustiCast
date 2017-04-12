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



//Gives global identifier to any class that conforms to UIResponder (all views conform to the UI responder)
//Useful in situations dealing with segues identifiers
extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
