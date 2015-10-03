//
//  OTMAnnotationModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/2/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import Foundation
import MapKit

class OTMAnnotationModel: NSObject, MKAnnotation {
    var coordinate       : CLLocationCoordinate2D
    var title   : String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
