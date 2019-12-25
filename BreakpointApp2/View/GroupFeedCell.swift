//
//  GroupFeedCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-25.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, post: String) {
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.postLabel.text = post
    }
    

}
