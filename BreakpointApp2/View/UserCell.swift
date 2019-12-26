//
//  UserCell.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-18.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    var showing = false
    
    func configureCell(uid: String, email: String, isSelected: Bool) {
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
        if isSelected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            } else {
                checkImage.isHidden = true
                showing = false
            }
        }
    }

}
