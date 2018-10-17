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
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    var selectedPhoto: UIImage? {
        didSet {
            self.photoImageView.image = selectedPhoto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    fileprivate func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewOrEditUserViewController.photoTaped))
        self.photoImageView.addGestureRecognizer(tap)
        self.photoImageView.isUserInteractionEnabled = true
        self.newUserButton.isEnabled = false
    }
    
    @objc func photoTaped() {
        self.presentPhotoPickerActionSheet()
    }
    
    @IBAction func newUserButtonTapped(_ sender: Any) {
        let imageUploadGroup = DispatchGroup()
        let tempImageID = UUID().uuidString
        var newUser = User(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text)
        
        if let existSelectedPhoto = selectedPhoto {
            imageUploadGroup.enter()
            self.showLoadingIndicator()
            IMGURManager.post(image: existSelectedPhoto, for: tempImageID, success: { imageURL in
                self.hideLoadingIndicator()
                newUser.imageUrl = imageURL
                imageUploadGroup.leave()
            }, failed: { error in
                imageUploadGroup.leave()
                self.hideLoadingIndicator()
                if let error = error {
                    self.showError(error: error)
                }
            })
        } else {
            self.createNew(user: newUser)
        }
        
        imageUploadGroup.notify(queue: .main) {
            self.createNew(user: newUser)
        }
    }
    
    private func createNew(user: User) {
        self.showLoadingIndicator()
        NetworkManager.newUser(user: user, success: {
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

extension NewOrEditUserViewController {
    @objc func validateTextField(_ textField: UITextField) {
        self.newUserButton.isEnabled = false
        
        guard let first = self.firstNameTextField.text, first != "" else {
            self.firstNameErrorLabel.text = "First Name field is empty"
            return
        }
        self.firstNameErrorLabel.text = ""
        
        guard let second = self.lastNameTextField.text, second != "" else {
            self.lastNameErrorLabel.text = "Last Name field is empty"
            return
        }
        self.lastNameErrorLabel.text = ""
        
        guard let third = self.emailTextField.text, third.isEmailValid() else {
            self.emailErrorLabel.text = "Email is incorrect"
            return
        }
        self.emailErrorLabel.text = ""
        
        self.newUserButton.isEnabled = true
    }

}

extension NewOrEditUserViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.validateTextField(textField)
        self.view.endEditing(false)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.validateTextField(textField)
        return true
    }
}
