//
//  ViewController.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 03/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    var appDelegate: AppDelegate!
    var annotations = [MKPointAnnotation]()
    var completeInfo = [[String:AnyObject]]()
        override func viewDidLoad() {
        super.viewDidLoad()
//Calling studentsLocations in viewDidLoad, after the data was retrieved by the request.
            self.studentsLocations()
            
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
//Store Constans.Locations.studentsLocations in "results"
            Constants.Locations.studentsLocations = results
            print(Constants.Locations.studentsLocations)
      
            
// Constants.Locations.studentsLocation now is stored in results. Now results is stored in complete info and now contains data
            self.completeInfo = results
            
//Here we updated the map view to populate the map with pins calling the studentsLocations() method.
            performUIUpdatesOnMain {
                self.studentsLocations()
            }
         
           }
//complete the task.
        task.resume()
    
    }

 
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
  
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }else{
            pinView!.annotation = annotation
        }
        return pinView
      
        }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
            
            }
        }
//This function updates the mapView
    func studentsLocations()  {
        
        let locations = completeInfo
        
        for dictionary in locations {
            
            guard let lat: CLLocationDegrees = dictionary["latitude"] as? Double else  {
//Continue is for tell the bucle to keep going even if the value doesn't exist or is another type.
                continue
                return
             }
           
            guard let lon: CLLocationDegrees = dictionary["longitude"] as? Double else{
//Continue is for tell the bucle to keep going even if the value doesn't exist or is another type.
                continue
                return
            }
            
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let first = dictionary["firstName"] as AnyObject
        let last = dictionary["lastName"] as AnyObject
        let mediaURL = dictionary["mediaURL"] as AnyObject
            
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            
            
            annotations.append(annotation)
        }
                MapView.delegate = self
                self.MapView.addAnnotations(self.annotations)
            
    }
    

}














