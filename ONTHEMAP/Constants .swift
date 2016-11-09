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
        static let Limit = "100"
        static let Skip = "400"
        static let Results = "results"
        static let StatusCode = "status_code"
        static let StatusMessage = "status_message"
    }
    struct Locations {
        
        static var studentsLocations: [[String:AnyObject]]!
       
    }
    
    struct StudentInfo {
        
    }
    struct ParseResponseValues {
        static let OKStatus = "ok"
    }
    
}

