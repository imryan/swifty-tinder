//
//  STPersonalProfile.swift
//  SwiftyTinder
//
//  Created by Ryan Cohen on 8/1/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import Foundation

public class STPersonalProfile : STProfile {
    
    var lastActiveTime: String
    var createdAtTime: String
    
    var distanceFilter: Int
    var ageFilterMin: Int
    var ageFilterMax: Int
    
    var discoverable: Bool
    var genderFilter: STGenderType
    
    var interests: [STInterest] = []
    
    override init(dictionary: NSDictionary) {
        self.lastActiveTime = dictionary["active_time"] as! String
        self.createdAtTime = dictionary["create_date"] as! String
        
        self.distanceFilter = dictionary["distance_filter"] as! Int
        self.ageFilterMin = dictionary["age_filter_min"] as! Int
        self.ageFilterMax = dictionary["age_filter_max"] as! Int
        
        self.discoverable = dictionary["discoverable"] as! Bool
        self.genderFilter = STGenderType(rawValue: dictionary["gender_filter"] as! Int)!
        
        for interest in dictionary["interests"] as! [NSDictionary] {
            let interest = STInterest(id: interest["id"] as! String, name: interest["name"] as! String)
            interests.append(interest)
        }
        
        super.init(dictionary: dictionary)
    }
}