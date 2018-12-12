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
    
    //IBOutlets//
    @IBOutlet weak var textField: UITextField!
    
    //Dismiss view without doing anything
    @IBAction func tappedDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
        //Create a new board with the information specified
        Requests.createUserBoard(board_name: (textField.text ?? "").trimmingCharacters(in: .whitespaces)) { (board) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                if board != nil {
                    //If the operation is successful, notify so content can be updated
                    NotificationCenter.default.post(name: NSNotification.Name("newBoard"), object: nil)
                }
            }
        }
    }
    
    
    
}
