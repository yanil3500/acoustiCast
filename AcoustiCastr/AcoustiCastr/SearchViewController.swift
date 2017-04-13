//
//  SearchViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allPodcasts = [Podcast](){
        didSet{
            print("FirsCall: \(self.allPodcasts.count)")
            self.tableView.reloadData()
        }
    }
    var button_tag = -1
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //TODO: Finish delegate methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPodcasts.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == button_tag {
            return 300
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
