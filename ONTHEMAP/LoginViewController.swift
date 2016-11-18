//
//  LoginViewController.swift
//  ONTHEMAP
//
//  Created by Delberto Martinez on 14/11/16.
//  Copyright © 2016 Delberto Martinez. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    var keybordOnScreen = false
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var DebugTextLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if UserNameTextField.text!.isEmpty ||
            PasswordTextField.text!.isEmpty {
            self.setUIEnabled(enabled: true)
            self.DebugTextLabel.text! = "Login Failed"
        }else{
            getRequesToken()
        }
    }
    private func completeLogin(){
        performUIUpdatesOnMain {
            self.DebugTextLabel.text = ""
            self.setUIEnabled(enabled: true)
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "MapTabBarController") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        }
    }
    func getRequesToken() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(Constants.Udacity)")! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(UserNameTextField.text!)\", \"password\": \"\(PasswordTextField.text!)\"}}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func displayErrorInLabel(error: String, debugTextLabel: String? = nil) {
                print(error)
                performUIUpdatesOnMain {
                self.DebugTextLabel.text = "Login failed"
                }
            }
            
            guard (error == nil) else {
                print("Hubo un error con la petición \(error)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("La petición regreso un valor diferente a 2xx \(response)")
                return
            }
            
            guard let data = data else {
                print("No se regresaron los datos después de la petición")
                return
            }
            
            let dataLength = data.count
            let range = 5...Int(dataLength)
            let newData = data.subdata(in: Range(range))
            print(NSString(data:newData, encoding: String.Encoding.utf8.rawValue))
            
            let parsedResult : [String:AnyObject]
            do{
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            }catch{
                print("No se pudieron analizar los datos como JSON: '\(newData)'")
                return
            }
            if let results = parsedResult["session"] as? [String:AnyObject] {
                let sessionID = results["id"] as! String
                print("session \(sessionID)")
            }
            self.setUIEnabled(enabled: true)
            self.completeLogin()
        }
    task.resume()
    }
}
extension LoginViewController {
    func setUIEnabled(enabled: Bool) {
        UserNameTextField.isEnabled = enabled
        PasswordTextField.isEnabled = enabled
        LoginButton.isEnabled = enabled
        DebugTextLabel.isEnabled = enabled
        DebugTextLabel.text = ""
    }
}
