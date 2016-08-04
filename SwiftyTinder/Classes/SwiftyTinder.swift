//
//  SwiftyTinder.swift
//  SwiftyTinder
//
//  Created by Ryan Cohen on 7/31/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import Foundation
import Alamofire

public class SwiftyTinder {
    
    private let TINDER_AUTH_URL = "https://api.gotinder.com/auth"
    private let TINDER_GET_USERS_URL = "https://api.gotinder.com/user/recs"
    
    private var token: String?
    private var authenticated: Bool!
    
    public init() {
        //
    }
    
    // MARK: - Authentication
    
    /**
     Authenticates with Facebook token and returns Tinder token
     
     - returns: `success`, `token`
     */
    public func authenticate(facebookToken: String, completion: (success: Bool, token: String?, profile: STPersonalProfile?) -> ()) {
        let paremeters = [
            "facebook_token" : facebookToken
        ]
        
        Alamofire.request(.POST, TINDER_AUTH_URL, parameters: paremeters).responseJSON { (response) in
            if response.response?.statusCode == 401 {
                completion(success: false, token: nil, profile: nil)
            } else {
                if let JSON = response.result.value {
                    let profile = STPersonalProfile(dictionary: JSON["user"] as! NSDictionary)
                    
                    if let token = JSON["token"]  {
                        self.token = token as? String
                        completion(success: true, token: self.token, profile: profile)
                    }
                }
            }
        }
    }
    
    // MARK: - API Functions
    
    /**
     Returns 11 user profile objects
     
     - returns: `success`, `[STProfile]`
     */
    public func getRecommendations(completion: (success: Bool, profiles: [STProfile]?) -> ()) {
        if let token = token {
            let headers = ["X-Auth-Token" : token]
            
            Alamofire.request(.GET, TINDER_GET_USERS_URL, headers: headers).responseJSON { (response) in
                if response.response?.statusCode == 401 {
                    completion(success: false, profiles: nil)
                } else {
                    if let JSON = response.result.value {
                        var profiles: [STProfile] = []
                        
                        for profile in JSON["results"] as! [NSDictionary] {
                            profiles.append(STProfile(dictionary: profile))
                        }
                        
                        completion(success: true, profiles: profiles)
                    }
                }
            }
            
        } else {
            completion(success: false, profiles: nil)
        }
    }
}