//
//  CreateGroupVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-18.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var addMemberTextField: InsetTextField!
    @IBOutlet weak var addMemberLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
    }
    
}
