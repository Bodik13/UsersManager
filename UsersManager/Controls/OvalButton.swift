//
//  OvalButton.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/20/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

class OvalButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
