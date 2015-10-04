//
//  OTMUserModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/2/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMUserModel: OTMStudentLocationModel {
    var login         : String!
    var password      : String!
    
    func fill(dictionary: [String: AnyObject]){
        if let session = dictionary["session"] as? [String: AnyObject] {
            self.objectId = session["id"] as! String
            if let account = dictionary["account"] as? [String: AnyObject] {
                self.uniqueKey = account["key"] as! String
            }
        }
        
        if let userResponse = dictionary["user"] as? [String: AnyObject] {
            self.firstName = userResponse["first_name"] as! String
            self.lastName = userResponse["last_name"] as! String
        }
    }
}
