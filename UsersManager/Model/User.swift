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
    
    init(firstName: String? = "", lastName: String? = "", email: String? = "", imageUrl: String? = "", createdDate: Date = Date(), updatedDate: Date = Date()) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.imageUrl = imageUrl
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
    
    init(dictData: [String : Any]?) {
        let dictData = dictData ?? [:]
        
        if let id = dictData[Defaults.Keys.ID] as? String {
            self.id = id
        }
        
        if let firstName = dictData[Defaults.Keys.FIRST_NAME] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictData[Defaults.Keys.LAST_NAME] as? String {
            self.lastName = lastName
        }
        
        if let createdDateStr = dictData[Defaults.Keys.CREATED] as? String,
            let createdDate = DefaultDateFormatter.LocalDayWithHours.date(from: createdDateStr) {
            self.createdDate = createdDate
        }
        
        if let updatedDateStr = dictData[Defaults.Keys.UPDATED] as? String,
            let updatedDate = DefaultDateFormatter.LocalDayWithHours.date(from: updatedDateStr) {
            self.updatedDate = updatedDate
        }
        
        if let imageUrl = dictData[Defaults.Keys.IMAGE_URL] as? String {
            self.imageUrl = imageUrl
        }
        
        if let email = dictData[Defaults.Keys.EMAIL] as? String {
            self.email = email
        }
    }
    
    func toDict() -> [String: Any] {
        let entityDict: [String : Any] = [Defaults.Keys.FIRST_NAME  : self.firstName ?? "",
                                          Defaults.Keys.LAST_NAME   : self.lastName ?? "",
                                          Defaults.Keys.EMAIL       : self.email ?? "",
                                          Defaults.Keys.IMAGE_URL   : self.imageUrl ?? ""]
        
        return entityDict
    }
    
}
