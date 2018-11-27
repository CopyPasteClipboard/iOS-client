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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
        Requests.postNewBoardItem(board_id: board.id, text: textField.text ?? "") { (item) in
            print(item)
            DispatchQueue.main.async {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
}
