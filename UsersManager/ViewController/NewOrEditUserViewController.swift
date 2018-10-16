//
//  NewEditUserViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

class NewOrEditUserViewController: UIViewController, AlertDisplayable, ProgressDisplayable, PhotoPickerDisplayable {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newUserButton: UIButton!
    
    var imagePickerViewController: UIImagePickerController?
    var selectedPhoto = UIImage() {
        didSet {
            self.photoImageView.image = selectedPhoto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePickerViewController = UIImagePickerController()
        self.imagePickerViewController?.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewOrEditUserViewController.photoTaped))
        self.photoImageView.addGestureRecognizer(tap)
        self.photoImageView.isUserInteractionEnabled = true
    }
    
    @objc func photoTaped() {
        self.presentPhotoPickerActionSheet()
    }

    @IBAction func newUserButtonTapped(_ sender: Any) {
        let newUser = User(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text)
        
        self.showLoadingIndicator()
        NetworkManager.newUser(user: newUser, success: {
            self.hideLoadingIndicator()
           self.showAllert(with: "Success!", messege: "New user successfully added.")
        }) { (error) in
            self.hideLoadingIndicator()
            if let error = error { self.showError(error: error) }
        }
    }
   
}


extension NewOrEditUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedPhoto = image
        } else{
            print("Something went wrong in  image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
