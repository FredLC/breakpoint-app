//
//  RoundedImageView.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-26.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }

}
