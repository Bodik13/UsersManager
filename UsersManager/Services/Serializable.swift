//
//  Serializable.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/15/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

protocol Serializable {
    init(dictData: [String : Any]?)
    func toDict() -> [String : Any]
}
