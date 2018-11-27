//
//  BoardItemsVC.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit

class BoardItemsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var board: Board!
    var items = [Item]()
    
    override func viewDidLoad() {
        Requests.getBoardItems(board_id: board.id) { (items) in
            if let items = items {
                self.items = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func tappedAdd() {
        let view = AddBoardVC(nibName: "BoardItemsVC", bundle: nil)
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        cell.textLabel?.text = items[indexPath.row].text_content
        return cell
    }
    
    
}
