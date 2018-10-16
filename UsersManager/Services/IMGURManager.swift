//
//  IMGURManager.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/16/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit
import Alamofire

class IMGURManager {
    
    static func post(image: UIImage, for username: String, success: @escaping(String) -> (), failed: @escaping (Error?) -> ()) {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        
        let parameters = [
            Defaults.Keys.IMAGE: base64Image
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                multipartFormData.append(imageData, withName: username, fileName: "\(username).png", mimeType: "image/png")
            }
            
            for (key, value) in parameters {
                multipartFormData.append((value?.data(using: .utf8))!, withName: key)
            }}, to: Defaults.URLS.IMGUR.UPLOAD, method: .post, headers: [Defaults.Keys.AUTHORIZATION: "Client-ID " + Defaults.IMGUR.CLIENT_ID],
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response { response in
                            let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                            let imageDic = json?[Defaults.Keys.DATA] as? [String:Any]
                            if let imageURL = imageDic?[Defaults.Keys.LINK] as? String {
                                success(imageURL)
                            } else {
                                failed(nil)
                            }
                        }
                    case .failure(let encodingError):
                        print("error:\(encodingError)")
                        failed(encodingError)
                    }
        })
        
    }
}
