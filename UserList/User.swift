//
//  User.swift
//  UserList
//
//  Created by epita on 05/06/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

struct UserBase: Codable {
    let results: [RandomUser]
}
struct RandomUser: Codable {
    let gender: String
    let name:  UserName
}
struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

