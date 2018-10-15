//
//  ViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit
import AlamofireImage

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    let toNewUserIdentifier: String = "toNewUser"
    var usersList: [User] = [User]() {
        didSet {
            self.usersTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBottomPadding()
        self.loadUsers()
        
    }
    
    private func loadUsers() {
        NetworkManager.getUsers(success: { (users) in
            self.usersList = users
        }) { (error) in
            
        }
    }
    
    private func addBottomPadding() {
        let bottomPaddingHeight: CGFloat = 44
        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.usersTableView.bounds.width, height: bottomPaddingHeight))
        self.usersTableView.tableFooterView = footerView
    }

    @IBAction func newUserButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: self.toNewUserIdentifier, sender: self)
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        let user = self.usersList[indexPath.row]
        cell.textLabel?.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        cell.detailTextLabel?.text = user.email ?? "Email empty"
        
        cell.imageView?.image = UIImage(named: "icon_account")
        cell.imageView?.contentMode = .scaleAspectFit
        
        if let url = URL(string: user.imageUrl ?? "") {
            cell.imageView?.af_setImage(withURL: url)
        }
        
        return cell
    }
    
}
