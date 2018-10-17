//
//  UITextField.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/17/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

extension UITextField {
    
    func validateField(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "") }.reduce(true) { $0 && $1 }
    }
    
}
