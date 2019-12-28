//
//  MeVCPostCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-28.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase

class MeVCPostCell: UITableViewCell {

    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    func configureCell(email: String, post: String) {
        DataService.instance.getProfilePictureUrl(forUID: Auth.auth().currentUser!.uid) { (returnedImageUrl) in
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
