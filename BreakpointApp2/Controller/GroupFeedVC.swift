//
//  GroupFeedVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-25.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var sendMessageTextField: InsetTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMessageView.bindToKeyboard()
    }

    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
