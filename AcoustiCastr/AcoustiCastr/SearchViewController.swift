//
//  SearchViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var allPodcasts = [Podcast](){
        didSet{
            print("FirsCall: \(self.allPodcasts.count)")
            self.collectionView.reloadData()
        }
    }
    var searchTerm = [String]() {
        didSet {
            self.update()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
    }
    
    func update(){
        print("Inside of update:")
        iTunes.shared.getPodcasts { (podcasts) in
            if let pods = podcasts {
                self.allPodcasts = pods
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //TODO: Finish delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: return number of podcasts
        if self.allPodcasts.count != 0 {
            guard let firstPodcast = self.allPodcasts.first?.podcastFeed else { print("Failed to get episode");return -1 }
            RSS.shared.rssFeed = firstPodcast
            RSS.shared.getEpisodes(completion: { (episodes) in
                print("Podcast Description: \(String(describing: episodes?.first?.podDescription))")
            })
            
        }
        return self.allPodcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: Create your customize cell and set it over here
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Did select, do perform segue
        print("I selected \(indexPath.row)")
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
        self.searchBar.resignFirstResponder()
    }
}
