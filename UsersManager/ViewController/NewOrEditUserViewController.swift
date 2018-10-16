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
    
    var selectedPhoto: UIImage? {
        didSet {
            self.photoImageView.image = selectedPhoto
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewOrEditUserViewController.photoTaped))
        self.photoImageView.addGestureRecognizer(tap)
        self.photoImageView.isUserInteractionEnabled = true
        
        self.firstNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func photoTaped() {
        self.presentPhotoPickerActionSheet()
    }
    
    @IBAction func newUserButtonTapped(_ sender: Any) {
        let imageUploadGroup = DispatchGroup()
        let tempImageID = UUID().uuidString
        var storedImageURL: String?
        
        if let existSelectedPhoto = selectedPhoto {
            imageUploadGroup.enter()
            self.showLoadingIndicator()
            IMGURManager.post(image: existSelectedPhoto, for: tempImageID, success: { imageURL in
                self.hideLoadingIndicator()
                storedImageURL = imageURL
                imageUploadGroup.leave()
            }, failed: { error in
                imageUploadGroup.leave()
                self.hideLoadingIndicator()
                if let error = error {
                    self.showError(error: error)
                }
            })
        }
        
        imageUploadGroup.notify(queue: .main) {
            if let exitingImageURL = storedImageURL {
                let newUser = User(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text, imageUrl: exitingImageURL)
                self.createNew(user: newUser)
            }
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.newUserButton.isEnabled = false
        
        guard let first = self.firstNameTextField.text, first != "" else {
            print("textField 1 is empty")
            return
        }
        
        guard let second = self.lastNameTextField.text, second != "" else {
            print("textField 2 is empty")
            return
        }
        
        guard let third = self.emailTextField.text, third != "" else {
            print("textField 3 is empty")
            return
        }
        
        self.newUserButton.isEnabled = true
        
    }
}
