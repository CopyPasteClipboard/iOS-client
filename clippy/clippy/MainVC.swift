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
    var objProtocol: NSObjectProtocol!
    
    override func viewDidLoad() {
        loadData()
        
        objProtocol = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newBoard"), object: nil, queue: nil, using: { (notification) in
            self.loadData()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(objProtocol)
    }
    
    func loadData() {
        Requests.getUserBoards { (boards) in
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MainVCCell")
        cell.textLabel?.text = boards[indexPath.row].board_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let view = BoardItemsVC(nibName: "BoardItems", bundle: nil)
        view.board = boards[indexPath.row]
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func tappedAddBoard() {
        let view = AddBoardVC(nibName: "AddBoardView", bundle: nil)
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    
    
    
}
