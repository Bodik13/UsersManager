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
        Alamofire.request(Defaults.NetworkURLS.USERS).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value, let usersDict = json as? [[String: Any]] {
                    let users = usersDict.map { User(dictData: $0) }
                    print(users)
                    success(users)
                } else {
                    success([User]())
                }
            case .failure(let error):
                print(error)
                failed(error)
            }
        }
    }
    
    class func downloadImage(with url: String?, success: @escaping (UIImage) -> ()) {
        if let url = url {
            Alamofire.download(url).responseData { response in
                if let data = response.result.value {
                    if let image = UIImage(data: data) {
                       success(image)
                    }
                }
            }
        }
    }
    
}
