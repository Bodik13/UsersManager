//
//  DefaultValues.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/15/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

struct Defaults {
    
    struct NetworkURLS {
        static let DOMAIN = "https://cua-users.herokuapp.com/"
        static let USERS = DOMAIN + "users.php"
    }
    
    struct Keys {
        static let ID = "id"
        static let USER = "user"
        static let FIRST_NAME = "first_name"
        static let LAST_NAME = "last_name"
        static let EMAIL = "email"
        static let IMAGE_URL = "image_url"
        static let CREATED = "created"
        static let UPDATED = "updated"
    }
}
