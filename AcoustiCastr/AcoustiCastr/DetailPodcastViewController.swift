//
//  DetailPodcastViewController.swift
//  AcoustiCastr
//
//  Created by David Porter on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class DetailPodcastViewController: UIViewController {
    
    @IBOutlet weak var podcastArt: UIImageView!
    @IBOutlet weak var episodeView: UITableView!
    @IBOutlet weak var podcastTitle: UINavigationItem!
    var podcastDescription: String
    
    var episodes = [Episode]()
    
    //TODO: Add a table view for podcast
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
