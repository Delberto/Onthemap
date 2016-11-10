//
//  Constants .swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 03/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//
import UIKit

struct Constants {
    
    struct Parse {
        static let ParseURL = "https://parse.udacity.com/parse/classes/StudentLocation"
    }
    struct ParseParameterKeys {
        static let Limit = "limit"
        static let Skip = "Skip"
        
    }
    struct ParseResponseKeys {
        static let Limit = "2"
        static let Skip = "400"
        static let Results = "results"
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
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
    let name: String
    let location: String
    let mediaURL: String
    
    init(dictionary: [String : AnyObject])
    {
        let firstName = dictionary["firstName"] as! String
        let lastName = dictionary["lastName"] as! String
        self.name = "\(firstName) \(lastName)"
        self.location = dictionary["mapString"] as! String
        self.mediaURL = dictionary["mediaURL"] as! String
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
