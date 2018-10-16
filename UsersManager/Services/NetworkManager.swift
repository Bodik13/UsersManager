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
        Alamofire.request(Defaults.NetworkURLS.API.USERS).responseJSON { response in
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
        
        Alamofire.request(Defaults.NetworkURLS.API.USERS,
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
    
    static func post(image: UIImage, for username: String) {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        
        let parameters = [
            "image": base64Image
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                multipartFormData.append(imageData, withName: username, fileName: "\(username).png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.append((value?.data(using: .utf8))!, withName: key)
            }}, to: Defaults.NetworkURLS.IMGUR.UPLOAD, method: .post, headers: ["Authorization": "Client-ID " + "Constants.IMGUR_CLIENT_ID"],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response { response in
                            let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                            let imageDic = json?["data"] as? [String:Any]
                            print(imageDic?["link"])
                        }
                    case .failure(let encodingError):
                        print("error:\(encodingError)")
                    }
        })
        
    }
}
