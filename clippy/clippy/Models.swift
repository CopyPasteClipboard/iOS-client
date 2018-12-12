//
//  Models.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation

//Models for use by JSON decoder and across the app for fetching new content.

struct User: Decodable {
    
    //The current logged in user
    static var user: User!
    
    let id: Int
    let username: String!
}

struct Board: Decodable {
    let id: Int
    let board_name: String
}

struct Item: Decodable {
    let id: Int
    let text_content: String
}
