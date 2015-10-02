//
//  OTMStudentLocationModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import CoreLocation

class OTMStudentLocationModel: NSObject {
    var objectId   : String!
    var uniqueKey  : String!
    var location   : CLLocation!
    var userName   : String!
    var surName    : String!
    var mapString  : String!
    var url        : NSURL!
    var updateDate : NSDate!
    
    init(result: [String: AnyObject]) {
        self.userName = result["firstName"] as! String
        self.surName = result["lastName"] as! String
        self.mapString = result["mapString"] as! String
        self.url = NSURL(string: result["mediaURL"] as! String)
        self.uniqueKey = result["uniqueKey"] as! String
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = OTMModelConstants.DateFormatter
        self.updateDate = dateFormatter.dateFromString(result["updatedAt"] as! String)
        
        if let lat = result["latitude"] as? Double {
            if let long = result["longitude"] as? Double {
                self.location = CLLocation(latitude: lat, longitude: long)
            }
        }
    }
}
