//
//  SignUpVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 12/11/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit

class SignUpVC: UIViewController {
    
    //IBOutlets//
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        //Style
        signUpBtn.layer.borderWidth = 1
        signUpBtn.layer.cornerRadius = 5
        signUpBtn.layer.borderColor = self.view.tintColor.cgColor
        
        //Nav Title
        self.title = "Sign up"
    }
    
    //Process user input and sign up if valid content exists
    @IBAction func tappedSignUp() {
        let username = (usernameField.text ?? " ").trimmingCharacters(in: .whitespaces)
        let password = (passwordField.text ?? " ").trimmingCharacters(in: .whitespaces)
        let phoneNum = (phoneNumberField.text ?? " ").trimmingCharacters(in: .whitespaces)
        
        if username.count == 0 || password.count == 0 || phoneNum.count == 0 {return}
        Requests.signup(username: username, password: password, phoneNumber: phoneNum) { (user) in
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
    
    
    
}
