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
    
    //IBOutlets//
    @IBOutlet weak var tableView: UITableView!
    
    //Variables
    var board: Board!
    var items = [Item]()
    var objProtocol: NSObjectProtocol!
    
    override func viewDidLoad() {
        //Load in data so by the time the view appears we have information
        loadData()
        
        //Set an observer to be notified when a new item is added
        objProtocol = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newItem"), object: nil, queue: nil, using: { (notification) in
            //Load in new item and refresh display
            self.loadData()
        })
    }
    
    deinit {
        //Remove the observer when we are deallocated so as not to crash on a notification event
        NotificationCenter.default.removeObserver(objProtocol)
    }
    
    //Load in the items and update the user interface upon success
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
    
    //IBActions//
    
    //User wants to add a new item
    @IBAction func tappedAdd() {
        let view = AddItemVC(nibName: "AddItemView", bundle: nil)
        view.board = board
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    //User wants to go back to boards
    @IBAction func tappedBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //User wants to manually load in the items
    @IBAction func refresh() {
        loadData()
    }
    
    //TableView delegate and DataSource
    
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
