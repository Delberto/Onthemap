//
//  Constants .swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 03/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//
import UIKit
import Foundation

struct Constants {
    
    struct Parse {
        static let ParseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
        
    }
    static let Udacity = "https://www.udacity.com/api/session"
    
    struct ParseParameterKeys {
        static let Limit = "limit"
        static let Order = "order"
        
    }
    struct ParseResponseKeys {
        static let Limit = "100"
        static let Skip = "400"
        static let Results = "results"
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
        static let Order = "-updatedAt"
    }
    
    struct Locations {
        
        static var studentsLocations: [[String:AnyObject]]!
       
    }
    

    struct ParseResponseValues {
        static let OKStatus = "ok"
    }
    
}

struct studentInformation
{
    let name: AnyObject?
    let location: AnyObject?
    let mediaURL: AnyObject?
    
    init(dictionary: [String : AnyObject])
    {
        let firstName = dictionary["firstName"] as! String
        let lastName = dictionary["lastName"] as! String
        self.name = "\(firstName) \(lastName)" as AnyObject?
        self.location = dictionary["mapString"] as AnyObject?
        self.mediaURL = dictionary["mediaURL"] as AnyObject?
    }
}

extension studentInformation
{
    static var studentInformations: [studentInformation] {
        
        var studentArray: [studentInformation] = []
        
        for dic in Constants.Locations.studentsLocations {
            
            studentArray.append(studentInformation(dictionary: dic))
        }
        
        return studentArray
    }
}
