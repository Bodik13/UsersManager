//
//  UIViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/20/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
