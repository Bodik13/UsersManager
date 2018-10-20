//
//  UserCell.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/20/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit

protocol ConfigurebleCell {
    func configure(user: User)
}

protocol CellActions: class {
    func didEmailButtonTapped(with email: String?)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var emailButton: UIButton!
    weak var delegate: CellActions?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.bounds.height/2
        self.userPhotoImageView.layer.borderWidth = 2
        self.userPhotoImageView.layer.borderColor = Defaults.Colors.EXPENSE_BTN_BG_COLOR.cgColor
        self.userPhotoImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        self.delegate?.didEmailButtonTapped(with: self.emailButton.titleLabel?.text)
    }
    
}

extension UserCell: ConfigurebleCell {
    
    func configure(user: User) {
        self.fullNameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        self.emailButton.setTitle(user.email ?? "Email empty", for: .normal)

        self.userPhotoImageView.image = UIImage(named: "icon_account")
        self.userPhotoImageView.contentMode = .scaleAspectFit

        if let url = URL(string: user.imageUrl ?? "") {
            self.userPhotoImageView.af_setImage(withURL: url)
        }
    }
    
}
