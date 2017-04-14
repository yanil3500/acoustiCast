//
//  SearchViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allPodcasts = [Podcast](){
        didSet{
            print("FirsCall: \(self.allPodcasts.count)")
            self.tableView.reloadData()
        }
    }
    
    var rowHeight = 50
    var searchTerm = [String]() {
        didSet {
            self.update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        
        //Register nib
        let podcastNib = UINib(nibName: SearchResultsCell.identifier, bundle: nil)
        print("Reuse ID: \(SearchResultsCell.identifier)")
        self.tableView.register(podcastNib, forCellReuseIdentifier: SearchResultsCell.identifier)
        
        self.tableView.estimatedRowHeight = CGFloat(rowHeight)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.update()
        
    }
    
    func update(){
        print("Inside of update:")
        iTunes.shared.getPodcasts { (podcasts) in
            if let pods = podcasts {
                self.allPodcasts = pods
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //TODO: Finish delegate methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPodcasts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResultsCell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.identifier, for: indexPath) as! SearchResultsCell
        
        searchResultsCell.podcastAuthor?.text = self.allPodcasts[indexPath.row].artistName
        searchResultsCell.podcastName?.text = self.allPodcasts[indexPath.row].collectionName
        searchResultsCell.podcastArt.image = self.allPodcasts[indexPath.row].podcastAlbumArt
        
        return searchResultsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: DetailPodcastViewController.identifier, sender: nil)
    }


}



//MARK: FirstTimeViewController conforms to UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
        }

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Dismissed the keyboard from the view once user clicks on cancel button
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Dismisses the keyboard from the view once user clicks search bar
        print("Stuff in search bar: \(String(describing: searchBar.text))")
        if let terms = searchBar.text?.lowercased().components(separatedBy: " ") {
            print("Inside of let branch: number of search terms: \(terms.count)")
            iTunes.shared.getSearchText(searchRequest: terms)
            self.searchTerm = terms
            print(iTunes.searchTerms)
        }
        self.activityIndicator.startAnimating()
        self.searchBar.resignFirstResponder()
    }
}

//MARK: Extension for segue preparation

extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        if segue.identifier == DetailPodcastViewController.identifier {
            //prepares podcast info.
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedPodcast = self.allPodcasts[selectedIndex]
                guard let destinationController = segue.destination as? DetailPodcastViewController else { print("Failed to prepare segue");return}
                guard let image = selectedPodcast.podcastAlbumArt else { print("Failed to get image"); return }
                destinationController.podcastArt?.image = image
                destinationController.podcastTitle.title = selectedPodcast.collectionName
                //hands rss feed from selected podcast to our RSS singleton
                RSS.shared.rssFeed = selectedPodcast.podcastFeed
                RSS.shared.getEpisodes(completion: { (episodes) in
                    guard let podcastEps = episodes else { print("failed to get episodes."); return }
                    destinationController.episodes = podcastEps
                })
            }
        }
    }
}
