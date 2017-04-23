//
//  Options.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit
import Foundation

class Options {
    let optionName : String
    let optionSegueIdentifier : String
    let optionIconFilePath : String
    var optionIcon : UIImage?
    init(_ optionName: String, _ optionSegueIdentifier: String, _ optionIconFilePath: String) {
        self.optionName = optionName
        self.optionSegueIdentifier = optionSegueIdentifier
        self.optionIconFilePath = optionIconFilePath
    }
}

