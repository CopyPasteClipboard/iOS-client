//
//  MainVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/8/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit


class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var boards = [Board]()
    
    override func viewDidLoad() {
        Requests.getUserBoards(user_id: 0) { (boards) in
            if let boards = boards {
                self.boards = boards
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    @IBAction func tappedAddBoard() {
        let view = AddBoardVC(nibName: "AddBoardVC", bundle: nil)
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    
    
    
}
