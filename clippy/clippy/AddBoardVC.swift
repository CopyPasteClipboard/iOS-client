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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSave() {
//        Requests.postNewBoardItem(board_id: <#T##Int#>, text: <#T##String#>) { (item) in
//            DispatchQueue.main.async {
//                self.navigationController?.dismiss(animated: true, completion: nil)
//            }
//        }
    }
    
    
    
}
