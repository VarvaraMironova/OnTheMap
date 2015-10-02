//
//  OTMStudentInfoCell.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/1/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMStudentInfoCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationImageView: UIImageView!

    func fillWithModel(model:OTMStudentLocationModel) {
        nameLabel.text = model.userName + "  " + model.surName
    }

}
