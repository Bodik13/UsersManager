//
//  String.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/17/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import Foundation

extension String {
    
    func evaluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else {
            return false
        }
        
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
    
    
    func isEmailValid() -> Bool {
        let regexp = "^[\\w!#$%&’*+/=?`{|}~^-]+(?:\\.[\\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$"
        return self.evaluate(with: regexp)
    }
    
}
