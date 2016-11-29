//
//  TableViewController.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 23/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
        
        var completeInfo = [[String:AnyObject]]()
        var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Making the request to the Parse server
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constants.Parse.ParseURL)?\(Constants.ParseParameterKeys.Limit)=\(Constants.ParseResponseKeys.Limit)")! as URL)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            
            guard (error == nil) else {
                print("Hubo un error con la petición \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("La petición regresó un status code diferente a 2xx")
                return
            }
            
            guard let data = data else {
                print("No se devolvieron datos de la petición")
                return
            }
            let parsedResult: [String:AnyObject]!
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
            }catch{
                print("No se pudieron analizar los datos como JSON '\(data)'")
                return
            }
            
            if let _ = parsedResult[Constants.ParseResponseKeys.StatusCode] as? Int {
                print("Parse a devuelto un error véase en '\(Constants.ParseResponseKeys.StatusCode)' y '\(Constants.ParseResponseKeys.StatusMessage)' in \(parsedResult)")
                return
            }
            guard let results = parsedResult[Constants.ParseResponseKeys.Results] as? [[String: AnyObject]] else {
                print("No se pudieron encontrar los resultados '\(Constants.ParseResponseKeys.Results)' en \(parsedResult)")
                
                return
            }
//Store the data
            self.completeInfo = results
            performUIUpdatesOnMain {
                self.tableView.reloadData()
            }
            
        }
        //complete the task.
        task.resume()
        
    }

}
extension TableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "TableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        return cell
    }
}
