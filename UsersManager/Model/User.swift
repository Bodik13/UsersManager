//
//  User.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

struct User {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var imageUrl: String?
    var createdDate: Date?
    var updatedDate: Date?
}

extension User: Serializable {
    
    init(dictData: [String : Any]?) {
        let dictData = dictData ?? [:]
        
        if let id = dictData["id"] as? String {
            self.id = id
        }
        
        if let firstName = dictData["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictData["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let createdDateStr = dictData["created"] as? String,
            let createdDate = DefaultDateFormatter.LocalDayWithHours.date(from: createdDateStr) {
            self.createdDate = createdDate
        }
        
        if let updatedDateStr = dictData["updated"] as? String,
            let updatedDate = DefaultDateFormatter.LocalDayWithHours.date(from: updatedDateStr) {
            self.updatedDate = updatedDate
        }
        
        if let imageUrl = dictData["image_url"] as? String {
            self.imageUrl = imageUrl
        }
        
        if let email = dictData["email"] as? String {
            self.email = email
        }
    }
    
    func toDict() -> [String : Any] {
        return [:]
    }
    
    
}
