//
//  MenuViewController.swift
//  AcoustiCastr
//
//  Created by Elyanil Liranzo Castro on 4/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    var options = [Options]()
    var rowHeight = 50
    @IBOutlet weak var menuView: UITableView!
    override func viewDidLoad() {
        let myPodcasts = Options("My Podcasts", "MyPodcastsViewController", "download__2_@3x.png")
        let discover = Options("Discover", "DiscoverViewController", "Google_Web_Search_000000_100@3x.png" )
        options.append(myPodcasts)
        options.append(discover)
        super.viewDidLoad()
        self.menuView.delegate = self
        self.menuView.dataSource = self
        
        //Register
        let optionNib = UINib(nibName: OptionsViewCell.identifier, bundle: nil)
        self.menuView.register(optionNib, forCellReuseIdentifier: OptionsViewCell.identifier)
        
        self.menuView.estimatedRowHeight = CGFloat(rowHeight)
        
        self.menuView.rowHeight = UITableViewAutomaticDimension
        
        
        // Do any additional setup after loading the view.
    }
    


}

extension OptionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsViewCell.identifier, for: indexPath) as! OptionsViewCell
        cell.optionName.text = options[indexPath.row].optionName
        cell.icon.image = options[indexPath.row].optionIcon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: options[indexPath.row].optionSegueIdentifier, sender: nil)
    }
    
}


extension OptionsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == MyPodcastsViewController.identifier {
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
        } else if segue.identifier == DiscoverViewController.identifier {
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
        }
    }
}
