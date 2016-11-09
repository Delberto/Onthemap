//
//  StudentsInformation.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 09/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//

import Foundation
import UIKit

struct studentInformation {
    
    let name: String
    let location: String
    var mediaURL = String()
    
    init(dictionary: [String:AnyObject]) {
        let firstName = dictionary["firstName"] as! String
        let lastName = dictionary["lastName"] as! String
        self.name = "\(firstName) \(lastName)"
        self.location = dictionary["mapString"] as! String
        self.mediaURL = dictionary["mediaURL"] as! String
    }
}
    extension studentInformation {
        static var studentInfo: [studentInformation] {
            var studentArray: [studentInformation] = []
            for dictionary in Constants.Locations.studentsLocations! {
                studentArray.append(studentInformation(dictionary:dictionary))
            }
            return studentArray
        }
    }
