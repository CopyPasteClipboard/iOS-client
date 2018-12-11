//
//  LogInVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/8/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit


class LogInVC: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        
        logInBtn.layer.borderColor = self.view.tintColor.cgColor
        logInBtn.layer.borderWidth = 1
        logInBtn.layer.cornerRadius = 10
    }
    
    @IBAction func tappedLogIn() {
        Requests.login(username: "bruce@skoller.co") { (user) in
            if user != nil {
                DispatchQueue.main.async {
                    let nav = UINavigationController(rootViewController: MainVC(nibName: "MainView", bundle: nil))
                    nav.isNavigationBarHidden = true
                    self.navigationController?.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
    
}
