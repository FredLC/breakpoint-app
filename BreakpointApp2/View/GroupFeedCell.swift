//
//  GroupFeedCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-25.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    func configureCell(uid: String, email: String, post: String) {
        DataService.instance.getProfilePictureUrl(forUID: uid) { (returnedImageUrl) in
            if returnedImageUrl == "defaultProfileImage" {
                self.profileImage.image = UIImage(named: returnedImageUrl)
            } else {
                let imageString = returnedImageUrl
                let imageUrl = URL(string: imageString)
                let placeholder = UIImage(named: "defaultProfileImage")
                self.profileImage.kf.setImage(with: imageUrl, placeholder: placeholder)
            }
        }
        self.emailLabel.text = email
        self.postLabel.text = post
    }
    

}
