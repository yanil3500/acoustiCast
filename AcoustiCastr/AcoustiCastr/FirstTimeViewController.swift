//
//  FirstTimeViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/12/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class FirstTimeViewController: UIViewController {
    var searchTerms = [String]()
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
    }
}


//MARK: FirstTimeViewController conforms to UISearchBarDelegate
extension FirstTimeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
        }
//        guard let searchedText = searchBar.text else { return; }
//        //Populates table according to what user is searching for
//        self.displayRepos = self.repos.filter({ (repo) -> Bool in
//            repo.repoName.contains(searchedText)
//        })
//        
//        if searchBar.text == "" {
//            self.displayRepos = nil
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Dismissed the keyboard from the view once user clicks on cancel button
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Dismisses the keyboard from the view once user clicks search bar
        print("Stuff in search bar: \(String(describing: searchBar.text))")
        if let terms = searchBar.text?.lowercased().components(separatedBy: " ") {
            self.searchTerms = terms
            print("Inside of let branch: \(self.searchTerms.count)")
        }
        self.searchBar.resignFirstResponder()
    }
}
