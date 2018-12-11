//
//  AddBoardVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit


class AddBoardVC: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func tappedDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
        
        Requests.createUserBoard(board_name: (textField.text ?? "").trimmingCharacters(in: .whitespaces)) { (board) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                if board != nil {
                    NotificationCenter.default.post(name: NSNotification.Name("newBoard"), object: nil)
                }
            }
        }
    }
    
    
    
}
