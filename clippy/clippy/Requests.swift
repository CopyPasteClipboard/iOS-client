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
    
    //One stop shop to change which ENV we are using
    static let baseUrl = URL(string: "http://54.162.248.95:4000/")!//URL(string: "http://localhost:4000/")!//
    
    static func getUserById(id: Int, completion: @escaping (User?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "/v1/user/\(id)", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                completion(user)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API Request to create a user. Calls completion upon finishing with the result of the operation (nil if failed)
    static func createUserBoard(board_name: String, completion: @escaping (Board?) -> Void) {
        var request = URLRequest(url: URL(string: "/v1/clipboard", relativeTo: baseUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let body = try? JSONSerialization.data(withJSONObject: ["board_name": board_name, "user_id": User.user.id], options: []) else {completion(nil);return}
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil, let data = data, let board = try? JSONDecoder().decode(Board.self, from: data) {
                completion(board)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API Request to get the user's boards. Calls completion upon finishing with the result of the operation (nil if failed)
    static func getUserBoards(completion: @escaping ([Board]?) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "/v1/user/\(User.user!.id)/clipboards", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let boards = try? JSONDecoder().decode([Board].self, from: data) {
                completion(boards)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API request to get a board's items. Calls completion upon finishing with the result of the operation (nil if failed)
    static func getBoardItems(board_id: Int, completion: @escaping ([Item]?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "/v1/clipboard/\(board_id)?type=all", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let items = try? JSONDecoder().decode([Item].self, from: data) {
                completion(items)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API request to get the most recent board item for the id specified. Calls completion upon finishing with the result of the operation (nil if failed)
    static func getLastBoardItem(board_id: Int, completion: @escaping ([Item]?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "/v1/clipboard/\(board_id)?type=most_recent", relativeTo: baseUrl)!) { (data, response, error) in
            if let data = data, let item = try? JSONDecoder().decode([Item].self, from: data) {
                completion(item)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API request to create a new board item. Calls completion upon finishing with the result of the operation (nil if failed)
    static func postNewBoardItem(board_id: Int, text: String, completion: @escaping (Item?) -> Void) {
        var request = URLRequest(url: URL(string: "/v1/clipboard/\(board_id)/boarditem", relativeTo: baseUrl)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: ["board_item": text], options: []) else {completion(nil); return}
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let item = try? JSONDecoder().decode(Item.self, from: data) {
                completion(item)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API request to log in the user with the username provided. Calls completion upon finishing with the result of the operation (nil if failed)
    static func login(username: String, completion: @escaping (User?) -> Void) {
        var request = URLRequest(url: URL(string: "/v1/login", relativeTo: baseUrl)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: ["username": username], options: []) else {completion(nil); return}
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                User.user = user
                completion(user)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    //API request to sign up the user with the information provided. Calls completion upon finishing with the result of the operation (nil if failed)
    static func signup (username: String, password: String, phoneNumber: String, completion: @escaping (User?) -> Void) {
        var request = URLRequest(url: URL(string: "/v1/user", relativeTo: baseUrl)!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: ["username": username, "password": password, "phone_number": phoneNumber], options: []) else {completion(nil); return}
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let user = try? JSONDecoder().decode(User.self, from: data) {
                User.user = user
                completion(user)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    
    
}
