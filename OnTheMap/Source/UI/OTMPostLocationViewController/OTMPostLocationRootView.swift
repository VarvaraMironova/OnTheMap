//
//  OTMPostLocationRootView.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/3/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import MapKit

class OTMPostLocationRootView: OTMView {
    @IBOutlet var searchButton              : UIButton!
    @IBOutlet var submitButton              : UIButton!
    @IBOutlet var cancelButton              : UIButton!
    
    @IBOutlet var mapView                   : MKMapView!
    
    @IBOutlet var linkTextField             : UITextField!
    @IBOutlet var locationTextField         : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTextFields()
        updateButtons()
    }
    
    func updateTextFields() {
        linkTextField.hidden = locationTextField.text!.isEmpty
        locationTextField.hidden = !linkTextField.hidden
    }
    
    func updateButtons() {
        searchButton.enabled = !locationTextField.text!.isEmpty
        searchButton.hidden = !locationTextField.text!.isEmpty && !linkTextField.text!.isEmpty
        submitButton.hidden = !searchButton.hidden
    }
    
}
