//
//  OTMStudentLocationModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import CoreLocation

struct OTMStudentLocationModel {
    var objectId   : String!
    var uniqueKey  : String!
    var annotation : OTMAnnotationModel!
    var firstName  : String!
    var lastName   : String!
    var mapString  : String! = ""
    var url        : NSURL! = NSURL(string: "")
    var updateDate : NSDate!
    
    init(result: [String: AnyObject]) {
        if let user = result["user"] as! [String : AnyObject]? {
            lastName = user["last_name"] as! String
            firstName = user["first_name"] as! String
            uniqueKey = user["key"] as! String
        } else {
            mapString = result["mapString"] as! String
            uniqueKey = result["uniqueKey"] as! String
            objectId = result["objectId"] as! String
            
            let firstName =  result["firstName"] as! String
            let lastName = result["lastName"] as! String
            let userName = firstName + "  " + lastName
            let urlString = result["mediaURL"] as! String
            
            self.firstName = firstName
            self.lastName = lastName
            url = NSURL(string: urlString)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = OTMModelConstants.DateFormatter
            updateDate = dateFormatter.dateFromString(result["updatedAt"] as! String)
            
            if let lat = result["latitude"] as? Double {
                if let long = result["longitude"] as? Double {
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    annotation = OTMAnnotationModel(coordinate: coordinate, title: userName, subtitle: urlString)
                }
            }
        }
    }

}
