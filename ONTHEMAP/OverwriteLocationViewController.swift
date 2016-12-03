//
//  OverwriteLocationViewController.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 30/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//

import Foundation
import UIKit

class OverwriteLocationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constants.Parse.ParseURL)")! as URL)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
    }
}
