//
//  ProgressDisplayable.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/16/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

protocol ProgressDisplayable {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

extension ProgressDisplayable where Self: UIViewController {
    
    var mainWindowView: UIView? {
        if let presentedVC = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController {
            return presentedVC.view
        }
        
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.view
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
