//
//  CreateGroupVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-18.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var addMemberTextField: InsetTextField!
    @IBOutlet weak var addMemberLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var chosenUsersArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addMemberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if addMemberTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: addMemberTextField.text!) { (returnedArray) in
                self.emailArray = returnedArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getUIDs(forUsernames: chosenUsersArray) { (idsArray) in
                var userIds = idsArray
                userIds.append(Auth.auth().currentUser!.uid)
                
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Error trying to create group. Please try again.")
                    }
                })
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {
            return UITableViewCell()
        }
        DataService.instance.getAllUids { (returnedUids) in
            let uid = returnedUids[indexPath.row]
            cell.configureCell(uid: uid, email: self.emailArray[indexPath.row], isSelected: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUsersArray.contains(cell.emailLabel.text!) {
            chosenUsersArray.append(cell.emailLabel.text!)
            addMemberLabel.text = chosenUsersArray.joined(separator: ", ")
            doneButton.isHidden = false
        } else {
            chosenUsersArray = chosenUsersArray.filter({ $0 != cell.emailLabel.text! })
            if chosenUsersArray.count >= 1 {
                addMemberLabel.text = chosenUsersArray.joined(separator: ", ")
            } else {
                addMemberLabel.text = "add member"
                doneButton.isHidden = true
            }
        }
    }
    
    
}


