//
//  OTMUserModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/2/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMUserModel {
    var id      : String!
    var key     : String!
    var login   : String!
    var password: String!
    var name    : String!
    var surName : String!
    
    func fill(dictionary: [String: AnyObject]){
        if let session = dictionary["session"] as? [String: AnyObject] {
            if let account = dictionary["account"] as? [String: AnyObject] {
                self.id = session["id"] as! String
                self.key = account["key"] as! String
            }
        }
    }
}
