//
//  STProfile.swift
//  SwiftyTinder
//
//  Created by Ryan Cohen on 7/31/16.
//  Copyright © 2016 Ryan Cohen. All rights reserved.
//

import Foundation

public class STProfile {
    
    public enum STGenderType: Int {
        case STGenderTypeMale = 0
        case STGenderTypeFemale = 1
    }
    
    public struct STInterest {
        var id: String
        var name: String
    }
    
    public struct STJob {
        var companyId: String?
        var company: String?
        
        var titleId: String?
        var title: String?
    }
    
    public struct STSchool {
        var id: String?
        var name: String?
        var year: String?
        var type: String?
    }
    
    public struct STPhoto {
        enum STPhotoSize: Int {
            case Size640 = 0
            case Size320 = 1
            case Size172 = 2
            case Size84 = 3
        }
        
        var photoURL: String?
        
        // [640x640], 320x320, 172x172, 84x84 are resolutions
        // => photos[i]["processed_files"][x]["url"]
        
        func photoWithSize(size: STPhotoSize) -> STPhoto {
            return STPhoto(photoURL: nil)
        }
    }
    
    public var id: String
    public var name: String
    public var birthdate: String // => "1996-09-04T00:00:00.000Z"
    public var distance: Int?
    public var bio: String
    public var gender: STGenderType
    
    public var photos: [STPhoto] = []
    public var jobs: [STJob]? = []
    public var schools: [STSchool]? = []
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["_id"] as! String
        self.name = dictionary["name"] as! String
        self.birthdate = dictionary["birth_date"] as! String
        self.distance = dictionary["distance_mi"] as? Int
        self.bio = dictionary["bio"] as! String
        self.gender = STGenderType(rawValue: dictionary["gender"] as! Int)!
        
        for photo in dictionary["photos"] as! [NSDictionary] {
            let photoURL = photo["url"] as! String
            let photoObject = STPhoto(photoURL: photoURL)
            
            photos.append(photoObject)
        }
        
        for job in dictionary["jobs"] as! [NSDictionary] {
            let companyId = job["company"]?["id"] as? String
            let companyName = job["company"]?["name"] as? String
            
            let jobId = job["title"]?["id"] as? String
            let jobName = job["title"]?["name"] as? String
            
            let job = STJob(companyId: companyId, company: companyName, titleId: jobId, title: jobName)
            jobs?.append(job)
        }
        
        for school in dictionary["schools"] as! [NSDictionary] {
            let schoolId = school["id"] as? String
            let schoolName = school["name"] as? String
            let schoolYear = school["year"] as? String
            let schoolType = school["type"] as? String
            
            let school = STSchool(id: schoolId, name: schoolName, year: schoolYear, type: schoolType)
            schools?.append(school)
        }
    }
}