//
//  ParentNavController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/20/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

class ParentNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.white
        
        self.navigationBar.barTintColor = Defaults.Colors.NAVBAR_BG_COLOR
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
