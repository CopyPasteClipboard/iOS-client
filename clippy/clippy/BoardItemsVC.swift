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
    var objProtocol: NSObjectProtocol!
    
    override func viewDidLoad() {
        loadData()
        
        objProtocol = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newItem"), object: nil, queue: nil, using: { (notification) in
            self.loadData()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(objProtocol)
    }
    
    func loadData() {
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
        let view = AddItemVC(nibName: "AddItemView", bundle: nil)
        view.board = board
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    @IBAction func tappedBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func refresh() {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "itemsVCCell")
        cell.textLabel?.text = items[indexPath.row].text_content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIPasteboard.general.string = items[indexPath.row].text_content
        let alert = UIAlertController(title: "Success!", message: "Copied to your clipboard", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
}
