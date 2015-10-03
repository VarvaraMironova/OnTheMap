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
    var annotation : OTMAnnotationModel!
    var firstName  : String!
    var lastName   : String!
    var mapString  : String!
    var url        : NSURL!
    var updateDate : NSDate!
    
    init(result: [String: AnyObject]) {
        self.mapString = result["mapString"] as! String
        self.uniqueKey = result["uniqueKey"] as! String
        
        let firstName =  result["firstName"] as! String
        let lastName = result["lastName"] as! String
        let userName = firstName + "  " + lastName
        let urlString = result["mediaURL"] as! String
        
        self.firstName = firstName
        self.lastName = lastName
        self.url = NSURL(string: urlString)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = OTMModelConstants.DateFormatter
        self.updateDate = dateFormatter.dateFromString(result["updatedAt"] as! String)
        
        if let lat = result["latitude"] as? Double {
            if let long = result["longitude"] as? Double {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                self.annotation = OTMAnnotationModel(coordinate: coordinate, title: userName, subtitle: urlString)
            }
        }
    }
}
