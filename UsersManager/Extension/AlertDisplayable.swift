//
//  UIViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/16/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

protocol AlertDisplayable {
    func showAllert(with title: String?, messege: String)
    func showError(error: Error)
}

extension AlertDisplayable where Self: UIViewController {
    
    func showAllert(with title: String? = nil, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error...", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
