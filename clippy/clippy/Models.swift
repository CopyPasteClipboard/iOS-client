//
//  Models.swift
//  clippy
//
//  Created by Bruce Brookshire on 11/27/18.
//  Copyright © 2018 bruce-brookshire.com. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int!
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
