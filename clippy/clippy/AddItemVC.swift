//
//  AddItemVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit


class AddItemVC: UIViewController {
    
    //IBOutlets//
    @IBOutlet weak var textField: UITextField!
    
    //Parent board for use in item creation
    var board: Board!
    
    //Dismiss the active view. user cancels operation.
    @IBAction func tappedDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
        //Create a new item with the information provided
        Requests.postNewBoardItem(board_id: board.id, text: textField.text ?? "") { (item) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                if item != nil {
                    //If the operation is successful, notify so content can be updated
                    NotificationCenter.default.post(name: NSNotification.Name("newItem"), object: nil)
                }
            }
        }
    }
    
    
    
}
