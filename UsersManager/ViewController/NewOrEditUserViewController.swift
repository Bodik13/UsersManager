//
//  NewEditUserViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit
import AlamofireImage

enum DisplayMode {
    case Edit
    case New
}

class NewOrEditUserViewController: UIViewController, AlertDisplayable, ProgressDisplayable, PhotoPickerDisplayable {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var newUserButton: OvalButton!
    
    var displayMode: DisplayMode = .New
    var selectedPhoto: UIImage? {
        didSet {
            self.photoImageView.image = selectedPhoto
        }
    }
    var user: User? {
        didSet {
            self.view.layoutIfNeeded()
            self.firstNameTextField.text = user?.firstName
            self.lastNameTextField.text = user?.lastName
            self.emailTextField.text = user?.email
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
        
        self.hideKeyboardWhenTappedAround()
        
        if let user = self.user, let imageURL = URL(string: user.imageUrl ?? "") {
            self.photoImageView.af_setImage(withURL: imageURL)
        }
        
        var titleText: String?
        switch self.displayMode {
        case .Edit:
            if let imageURL = URL(string: user?.imageUrl ?? "") {
                self.photoImageView.af_setImage(withURL: imageURL)
            }
            titleText = "Редактирование пользователя"
            self.newUserButton.setTitle("Сохранить", for: .normal)
            self.newUserButton.backgroundColor = Defaults.Colors.INCOME_BTN_BG_COLOR
        case .New:
            self.newUserButton.isEnabled = false
            titleText = "Создание пользователя"
            self.newUserButton.setTitle("Создать", for: .normal)
            self.newUserButton.backgroundColor = Defaults.Colors.EXPENSE_BTN_BG_COLOR
        }
        self.title = titleText
    }
    
    @objc func photoTaped() {
        self.presentPhotoPickerActionSheet()
    }
    
    @IBAction func newUserButtonTapped(_ sender: Any) {
        let imageUploadGroup = DispatchGroup()
        let tempImageID = UUID().uuidString
        var newUser = User(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, email: self.emailTextField.text)
        
        if let user = self.user {
            newUser.id = user.id
        }
        
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
            self.createUpdateUser(user: newUser, for: self.displayMode)
        }
        
        imageUploadGroup.notify(queue: .main) {
            self.createUpdateUser(user: newUser, for: self.displayMode)
        }
    }
    
    private func createUpdateUser(user: User, for displayMode: DisplayMode) {
        self.showLoadingIndicator()
        switch displayMode {
        case .New:
            NetworkManager.newUser(user: user, success: {
                self.hideLoadingIndicator()
                self.showAllert(with: "Success!", messege: "New user successfully added.", okAction: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
            }) { (error) in
                self.hideLoadingIndicator()
                if let error = error { self.showError(error: error) }
            }
        case .Edit:
            NetworkManager.updateUser(user: user, success: {
                self.hideLoadingIndicator()
                self.showAllert(with: "Success!", messege: "User successfully updated.", okAction: {_ in
                    self.navigationController?.popViewController(animated: true)
                })
            }) { (error) in
                self.hideLoadingIndicator()
                if let error = error { self.showError(error: error) }
            }
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
