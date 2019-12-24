//
//  GroupCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-24.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!
    
    func configureCell(title: String, description: String, membersCount: Int) {
        self.groupTitleLabel.text = title
        self.groupDescriptionLabel.text = description
        self.membersCountLabel.text = "\(membersCount) members"
    }
    

}
