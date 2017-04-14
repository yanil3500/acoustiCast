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
    var podcastDescription: String = ""
    
    var rowHeight = 50
    var episodes = [Episode]()
    
    //TODO: Add a table view for podcast
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodeView.delegate = self
        self.episodeView.dataSource = self
        print("Inside of podcastDetailViewController: ")
        
        
        //Register nib
        let episodeNib = UINib(nibName: DetailPodcastViewCell.identifier, bundle: nil)
        self.episodeView.register(episodeNib, forCellReuseIdentifier: DetailPodcastViewCell.identifier)
        self.episodeView.estimatedRowHeight = CGFloat(rowHeight)
        
        self.episodeView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension DetailPodcastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeCell = tableView.dequeueReusableCell(withIdentifier: DetailPodcastViewCell.identifier, for: indexPath) as! DetailPodcastViewCell
        
        episodeCell.episodeName.text = self.episodes[indexPath.row].title
        episodeCell.episodelink = self.episodes[indexPath.row].audiolink
        return episodeCell
    }
    

}
