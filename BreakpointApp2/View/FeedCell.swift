//
//  FeedCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-17.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCell(uid: String, email: String, content: String) {
        DataService.instance.getProfilePictureUrl(forUID: uid) { (returnedUrl) in
            if returnedUrl == "defaultProfileImage" {
                self.profileImage.image = UIImage(named: returnedUrl)
            } else {
                let imageString = returnedUrl
                let imageUrl = URL(string: imageString)
                let image = UIImage(named: "defaultProfileImage")
                self.profileImage.kf.setImage(with: imageUrl, placeholder: image)
            }
        }
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
    
}
