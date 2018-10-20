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
        let newUserUrl = Defaults.URLS.API.USERS
        self.newEditUser(user: user, withUrl: newUserUrl, success: success, failed: failed)
    }
    
    class func updateUser(user: User, success: @escaping () -> (), failed: @escaping (Error?) -> ()) {
        let updateUserUrl = "\(Defaults.URLS.API.EDIT_USER)\(user.id ?? "")"
        self.newEditUser(user: user, withUrl: updateUserUrl, success: success, failed: failed)
    }
    
    private class func newEditUser(user: User, withUrl: String, success: @escaping () -> (), failed: @escaping (Error?) -> ()) {
        let bodyParams = [Defaults.Keys.USER : user.toDict()]
        let utilityQueue = DispatchQueue.global(qos: .utility)
        Alamofire.request(withUrl,
                          method: .post,
                          parameters: bodyParams,
                          encoding: JSONEncoding.default).responseData(queue: utilityQueue) { response in
            switch response.result {
            case .success:
                success()
               
            case .failure(let error):
                failed(error)
            }
        }
    }
    
}


