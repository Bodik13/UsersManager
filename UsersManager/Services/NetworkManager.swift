//
//  NetworkManager.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/15/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    class func getUsers(success: @escaping ([User]) -> (), failed: @escaping (Error?) -> ()) {
        Alamofire.request(Defaults.URLS.API.USERS).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value, let usersDict = json as? [[String: Any]] {
                    let users = usersDict.map { User(dictData: $0) }
                    success(users)
                } else {
                    success([User]())
                }
            case .failure(let error):
                failed(error)
            }
        }
    }
    
    class func newUser(user: User, success: @escaping () -> (), failed: @escaping (Error?) -> ()) {
        let bodyParams = [Defaults.Keys.USER : user.toDict()]
        
        Alamofire.request(Defaults.URLS.API.USERS,
                          method: .post,
                          parameters: bodyParams,
                          encoding: JSONEncoding.default).responseJSON { response in
            let successStatusCode = 201
            switch response.result {
            case .success:
                if response.response?.statusCode == successStatusCode {
                    success()
                } else {
                    failed(nil)
                }
            case .failure(let error):
                failed(error)
            }
        }
    }
    
    
}


