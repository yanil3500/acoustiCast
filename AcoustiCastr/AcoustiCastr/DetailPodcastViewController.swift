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
    
    var selectedPod: Podcast!
    
    var podcastDescription: String = ""
    
    var rowHeight = 50
    var episodes = [Episode]()
    
    //TODO: Add a table view for podcast
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodeView.delegate = self
        self.episodeView.dataSource = self
        print("Inside of podcastDetailViewController: ")
        self.podcastArt.image = selectedPod.podcastAlbumArt
        self.podcastTitle.title = selectedPod.collectionName

        
        //Register nib
        let episodeNib = UINib(nibName: "PodcastDetailViewCell", bundle: Bundle.main)
        self.episodeView.register(episodeNib, forCellReuseIdentifier: "PodcastDetailViewCell")
        self.episodeView.estimatedRowHeight = CGFloat(rowHeight)
        
        self.episodeView.rowHeight = UITableViewAutomaticDimension
        
        //hands rss feed from selected podcast to our RSS singleton
        RSS.shared.rssFeed = selectedPod.podcastFeed
        RSS.shared.getEpisodes(completion: { (episodes) in
            guard let podcastEps = episodes else { print("failed to get episodes."); return }
            self.episodes = podcastEps
            self.episodeView.reloadData()
        })
    }


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // send your episode to playerVC
//        d
//    }

}


extension DetailPodcastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastDetailViewCell", for: indexPath) as! PodcastDetailViewCell
        
        cell.nameLabel.text = self.episodes[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: PlayerViewController.identifier, sender: nil)
    }

}


extension DetailPodcastViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlayerViewController.identifier {
        if let selectedIndex = self.episodeView.indexPathForSelectedRow?.row {
            let selectedEpisode = self.episodes[selectedIndex]
            guard let destinationController = segue.destination as? PlayerViewController else { print("Failed to prepare segue"); return }
            destinationController.episode = selectedEpisode
            destinationController.selectedPodcast = self.selectedPod
        }
        }
    }
}
