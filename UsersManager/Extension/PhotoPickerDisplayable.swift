//
//  PhotoPickerDisplayable.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/16/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

protocol PhotoPickerDisplayable {
    func presentPhotoPickerActionSheet()
}

extension PhotoPickerDisplayable where Self: UIViewController {
    
    func presentPhotoPickerActionSheet() {
        let alert = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take photo",
                                         style: .default,
                                         handler: { (alert: UIAlertAction!) in
                                           self.present(self.createImagePicker(.camera), animated: true, completion: nil)
        })
        let libraryAction = UIAlertAction(title: "Choose existing",
                                          style: .default,
                                          handler: { (alert: UIAlertAction!) in
                                            self.present(self.createImagePicker(.photoLibrary), animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func createImagePicker(_ sourceType:UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.sourceType = sourceType
        imagePicker.delegate = (self as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate))
        if (sourceType == .camera) {
            imagePicker.cameraCaptureMode = .photo
            imagePicker.showsCameraControls = true
        }
        
        return imagePicker
    }
    
}
