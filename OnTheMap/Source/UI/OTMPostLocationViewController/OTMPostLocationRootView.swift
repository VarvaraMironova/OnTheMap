//
//  OTMPostLocationRootView.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/3/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import MapKit

class OTMPostLocationRootView: UIView {
    @IBOutlet var enterLocationContainerView: UIView!
    @IBOutlet var mapContainerView          : UIView!
    @IBOutlet var locationTextView          : UITextView!
    
    @IBOutlet var searchButton              : UIButton!
    @IBOutlet var submitButton              : UIButton!
    @IBOutlet var cancelButton              : UIButton!
    
    @IBOutlet var mapView                   : MKMapView!
    
    @IBOutlet var linkTextField             : UITextField!
    @IBOutlet var locationTextField         : UITextField!
}
