//
//  DefaultValues.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/15/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

struct Defaults {
    
    struct URLS {
        struct API {
            static let DOMAIN = "https://cua-users.herokuapp.com/"
            static let USERS = DOMAIN + "users.php"
            static let EDIT_USER = DOMAIN + "edit_user.php?user_id="
        }
        
        struct IMGUR {
            static let DOMAIN = "https://api.imgur.com/"
            static let UPLOAD = DOMAIN + "3/upload"
        }
    }
    
    struct IMGUR {
        static let CLIENT_ID = "e3aabe04653d19a"
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
        static let AUTHORIZATION = "Authorization"
        static let IMAGE = "image"
        static let DATA = "data"
        static let LINK = "link"
    }
    
    struct Colors {
        static let NAVBAR_BG_COLOR = UIColor.init(hexString: "#DC6900") //#FF6347
        static let INCOME_BTN_BG_COLOR = UIColor.init(hexString: "#20B2AA")
        static let EXPENSE_BTN_BG_COLOR = UIColor.init(hexString: "#F08080")
        static let LIGHT_GREEN_COLOR = UIColor.init(hexString: "#8ed861")
        static let LIGHT_GREY_COLOR = UIColor.init(hexString: "#dddddd")
    }
}
