//
//  NewEditUserViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

class NewOrEditUserViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func newUserButtonTapped(_ sender: Any) {
        let newUser = User(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text)
        
        NetworkManager.newUser(user: newUser, success: {
           print(newUser)
        }) { (error) in
            
        }
    }
   
}
