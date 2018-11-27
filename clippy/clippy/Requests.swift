//
//  Requests.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation
import UIKit


class Requests {
    
    static let baseUrl = URL(string: "http://34.224.86.78:8080/v1")!
    
    static func getUserById(id: Int, completion: @escaping (User?) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "/users/\(id)", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                completion(user)
            } else {
                completion(nil)
            }
            }.resume()
        
    }
    
    static func getUserBoards(user_id: Int, completion: @escaping ([Board]?) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "/users/\(user_id)/clipboards", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let boards = try? JSONDecoder().decode([Board].self, from: data) {
                completion(boards)
            } else {
                completion(nil)
            }
            }.resume()
        
    }
    
    static func getBoardItems(board_id: Int, completion: @escaping ([Item]?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "/users/\(board_id)/clipboards", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let items = try? JSONDecoder().decode([Item].self, from: data) {
                completion(items)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    static func getLastBoardItem(board_id: Int, completion: @escaping (Item?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "/clipboard/\(board_id)", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let item = try? JSONDecoder().decode(Item.self, from: data) {
                completion(item)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    static func postNewBoardItem(board_id: Int, text: String, completion: @escaping (Item?) -> Void) {
        var request = URLRequest(url: URL(string: "/clipboard/\(board_id)/boarditem", relativeTo: baseUrl)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: ["text_content": text], options: []) else {completion(nil); return}
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let item = try? JSONDecoder().decode(Item.self, from: data) {
                completion(item)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    
    
}
