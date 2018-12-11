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
    @IBOutlet weak var textField: UITextField!
    
    var board: Board!
    
    @IBAction func tappedDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
        Requests.postNewBoardItem(board_id: board.id, text: textField.text ?? "") { (item) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                if item != nil {
                    NotificationCenter.default.post(name: NSNotification.Name("newItem"), object: nil)
                }
            }
        }
    }
    
    
    
}
