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
    //i think im being stupid. ill probably extract this into its own view
    //ALSO WHY DID I CALL IT A VIEW
    //its 1am and im mindlessly throwing this up instead of studying for my ai test tomorrow
    //ive slept like 5 hrs a night for about 6 months
    @IBOutlet weak var currentView: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    
}
