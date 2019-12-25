//
//  GroupFeedVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-25.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var sendMessageTextField: InsetTextField!
    
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLabel.text = group?.title
        DataService.instance.getEmails(forGroup: group!) { (returnedEmails) in
            self.membersLabel.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapShot) in
            DataService.instance.getAllMessages(forDesiredGroup: self.group!) { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .bottom, animated: true)
                }
            }
        }
    }

    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        if sendMessageTextField.text != "" {
            sendMessageTextField.isEnabled = false
            sendMessageButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: sendMessageTextField.text!, withUid: Auth.auth().currentUser!.uid, withGroupKey: group?.key) { (complete) in
                self.sendMessageTextField.text = ""
                self.sendMessageTextField.isEnabled = true
                self.sendMessageButton.isEnabled = true
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, post: message.content)
        }
        return cell
    }
    
    
}
