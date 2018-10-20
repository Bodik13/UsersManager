//
//  ViewController.swift
//  UsersManager
//
//  Created by Bohdan Hutsul on 10/11/18.
//  Copyright © 2018 Bohdan Hutsul. All rights reserved.
//

import UIKit
import AlamofireImage

class UsersListViewController: UIViewController, AlertDisplayable, ProgressDisplayable {
    
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var newUserButton: OvalButton!
    
    let toNewUserIdentifier: String = "toNewUser"
    let userCellIdentifier: String = "userCellIdentifier"
    var selectedUser: User?
    var usersList: [User] = [User]() {
        didSet {
            self.usersTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBottomPadding()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUsers()
    }
    
    private func setupView() {
        self.newUserButton.backgroundColor = Defaults.Colors.INCOME_BTN_BG_COLOR
        self.title = "Список пользователей"
        self.usersTableView.estimatedRowHeight = 100
        self.usersTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadUsers() {
        self.showLoadingIndicator()
        NetworkManager.getUsers(success: { (users) in
            self.hideLoadingIndicator()
            self.usersList = users
            self.selectedUser = nil
        }) { (error) in
            self.hideLoadingIndicator()
            if let error = error { self.showError(error: error) }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.toNewUserIdentifier {
            if let newEditViewController = segue.destination as? NewOrEditUserViewController,
                let selectedUser = self.selectedUser {
                newEditViewController.displayMode = .Edit
                newEditViewController.user = selectedUser
            }
        }
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.userCellIdentifier, for: indexPath) as! UserCell
        cell.delegate = self
        
        if let cell = cell as? ConfigurebleCell {
            let user = self.usersList[indexPath.row]
            cell.configure(user: user)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.selectedUser = self.usersList[indexPath.row]
            self.performSegue(withIdentifier: self.toNewUserIdentifier, sender: self)
        }
        
        edit.backgroundColor = Defaults.Colors.EXPENSE_BTN_BG_COLOR
        
        return [edit]
    }
}

extension UsersListViewController: CellActions {
    
    func didEmailButtonTapped(with email: String?) {
        if let url = URL(string: "mailto:\(email ?? "")") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
