//
//  ViewController.swift
//  TwitterTestApp
//
//  Created by CtanLI on 2019-10-20.
//  Copyright © 2019 twitterTestApp. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    private let MapController = "MapController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Register", comment: "The register Viewcontrollers title name")
        checkIfUserIsLoggedIn()
    }
    
    func loginTwitter() {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                UserDefaults.standard.set(session?.authToken, forKey: "Id")
                self.performSegue(withIdentifier: self.MapController, sender: nil)
            } else {
                print("error: \(error?.localizedDescription ?? "")")
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    func checkIfUserIsLoggedIn() {
        // Swift
        if UserDefaults.standard.string(forKey: "Id")  == nil {
            loginTwitter()
        } else {
            self.performSegue(withIdentifier: self.MapController, sender: nil)
        }
    }
}

