//
//  ViewController.swift
//  SwiftyTinder
//
//  Created by Ryan Cohen on 7/31/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import UIKit
import SwiftyTinder

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let tinder = SwiftyTinder()
    var profile: STPersonalProfile? = nil
    let token = "myToken"
    
    // MARK: - Authenticate & Fetch
    
    func authenticate(completion: (authenticated: Bool) -> ()) {
        tinder.authenticate(token) { (success, token, profile) in
            if success {
                print("Authenticated, got Tinder token: \(token)")
                self.profile = profile
                
                completion(authenticated: true)
            } else {
                print("Couldn't authenticate with Facebook token: (\(self.token))")
                completion(authenticated: false)
            }
        }
    }
    
    func fetchRecommendations() {
        tinder.getRecommendations { (success, profiles) in
            if success {
                if let profiles = profiles {
                    self.viewProfiles(profiles)
                }
            } else {
                print("Couldn't fetch recommendations. Check your Tinder token or connection.")
            }
        }
    }
    
    // MARK: - Data
    
    func viewProfiles(profiles: [STProfile]) {
        for profile in profiles {
            print("\(profile.name) is \(profile.distance!) mi away from you.")
        }
    }
    
    // MARK: - Table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Profile" : "Recommendations"
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let profileCellId = "ProfileCellId"
        let cellId = "CellId"
        
        if indexPath.section == 0 {
            let profileCell = tableView.dequeueReusableCellWithIdentifier(profileCellId, forIndexPath: indexPath) as! ProfileTableViewCell
            
            // Set image, name, details
            
            profileCell.profileImageView.image = UIImage(named: "empty-user")
            profileCell.nameLabel.text = "You, 18"
            
            return profileCell
            
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! ProfileTableViewCell
            
            // Set image, name, age, distance
            
            cell.profileImageView.image = UIImage(named: "empty-user")
            cell.nameLabel.text = "Jane, 18"
            cell.distanceLabel?.text = "6 mi away"
            
            return cell
        }
    }
    
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        authenticate { (authenticated) in
            self.fetchRecommendations()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
