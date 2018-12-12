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
    
    //IBOutlets//
    @IBOutlet weak var tableView: UITableView!
    
    //Variables//
    var boards = [Board]()
    var objProtocol: NSObjectProtocol!
    
    override func viewDidLoad() {
        //Load in data so we can display it when the view appears
        loadData()
        
        //Set an observer to be notified when a board is added
        objProtocol = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "newBoard"), object: nil, queue: nil, using: { (notification) in
            //Load in the new board data
            self.loadData()
        })
    }
    
    
    deinit {
        //Remove from notification center so we dont cause a crash
        NotificationCenter.default.removeObserver(objProtocol)
    }
    
    //Load in a user's boards and refresh UI upon success
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
    
    //TableView Datasource and Delegate funcs
    
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
    
    
    //IBActions//
    
    //User wants to add a new board
    @IBAction func tappedAddBoard() {
        let view = AddBoardVC(nibName: "AddBoardView", bundle: nil)
        self.navigationController?.present(view, animated: true, completion: nil)
    }
    
    //User wants to change to a different user. logout and reset local cache
    @IBAction func tappedLogout() {
        UserDefaults.standard.removeObject(forKey: "username")
        (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController = UINavigationController(rootViewController: LogInVC(nibName: "LogInView", bundle: nil))
        
    }
    
    
    
    
}
