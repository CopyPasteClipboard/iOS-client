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
    
    //IBOutlets//
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stylize
        usernameField.placeholder = "Username"
        
        logInBtn.layer.borderColor = self.view.tintColor.cgColor
        logInBtn.layer.borderWidth = 1
        logInBtn.layer.cornerRadius = 5
        
        signUpBtn.layer.borderColor = self.view.tintColor.cgColor
        signUpBtn.layer.borderWidth = 1
        signUpBtn.layer.cornerRadius = 5
        
        //Set nav bar title
        self.title = "Log in"
        
        //Check if we have credentials to use for auto-login.
        //if we do, log them in. otherwise, let them log in manually
        if let username = UserDefaults.standard.object(forKey: "username") as? String{
            Requests.login(username: username) { (user) in
                DispatchQueue.main.async {
                    if user != nil {
                        let nav = UINavigationController(rootViewController: MainVC(nibName: "MainView", bundle: nil))
                        nav.isNavigationBarHidden = true
                        (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController = nav
                    } else {
                        UserDefaults.standard.removeObject(forKey: "username")
                    }
                }
            }
        }
    }
    
    //IBActions//
    
    //Check inputs and attempt to log in
    @IBAction func tappedLogIn() {
        let username = (usernameField.text ?? "").trimmingCharacters(in: .whitespaces)
        if username.count == 0 {return}
        
        Requests.login(username: username) { (user) in
            if user != nil {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(username, forKey: "username")
                    let nav = UINavigationController(rootViewController: MainVC(nibName: "MainView", bundle: nil))
                    nav.isNavigationBarHidden = true
                    (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController = nav
                }
            }
        }
    }
    
    //Switch to signup view
    @IBAction func tappedSignUp() {
        self.navigationController?.pushViewController(SignUpVC(nibName: "SignUpView", bundle: nil) , animated: true)
    }
    
}
