//
//  OTMPostLocationViewController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/3/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OTMPostLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    var geocoder        : CLGeocoder!
    var userModel       : OTMStudentLocationModel!
    var rootView        : OTMPostLocationRootView! {
        get {
            if isViewLoaded() && self.view.isKindOfClass(OTMPostLocationRootView) {
                return self.view as! OTMPostLocationRootView
            } else {
                return nil
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            userModel = appDelegate.userModel
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        rootView.endEditing(true)
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        rootView.endEditing(true)
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSubmitButton(sender: AnyObject) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            appDelegate.userModel = userModel;
        }
        
        rootView.endEditing(true)
        
        rootView.showLoadingView()
        
        OTMClient.sharedInstance().postStudentInfo() {success, error in
            if (success) {
                if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                    let arrayModel = appDelegate.locations! as OTMArrayModel
                        
                    arrayModel.addModel(self.userModel)
                }
            }
                
            self.displayResult(error!, result: success)
        }
    }
    
    @IBAction func onSearchButton(sender: AnyObject) {
        rootView.endEditing(true)
        
        rootView.showLoadingView()
        
        let mapView = rootView.mapView
        geocoder = CLGeocoder()
        geocoder.geocodeAddressString(userModel.mapString, completionHandler: {placemarks, error in
            if nil != error {
                self.displayGeocodingError(error!)
            } else {
                if let placemark = placemarks?.first as CLPlacemark? {
                    let pin = MKPlacemark(placemark: placemark)
                    let coordinate = pin.coordinate as CLLocationCoordinate2D
                    let distane = 1000.0
                    let region = MKCoordinateRegionMakeWithDistance(coordinate, distane * 2.0, distane * 2.0)
                    let userModel = self.userModel
                    let userName = userModel.firstName + "  " + userModel.lastName
                    let annotationModel = OTMAnnotationModel(coordinate: coordinate, title: userName, subtitle: "")
                    self.userModel.annotation = annotationModel
                    
                    mapView.setRegion(region, animated: true)

                    mapView.addAnnotation(pin)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.rootView.updateTextFields()
                        self.rootView.hideLoadingView()
                    })
                }
            }
        })
        
        geocoder = nil
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldDidEndEditing(textField: UITextField) {
        let text = textField.text as String!
        switch (textField.tag) {
        //locationTextField
        case 1:
            userModel.mapString = text;
            break
            
        //linkTextField
        case 2:
            userModel.url = NSURL(string: text);
            break
            
        default:
            break
        }
        
        rootView.updateButtons()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    private func displayResult(message: String, result: Bool) {
        let title = result ? "Congratulations!" : "Oops!"
        let actionTitle = result ? "OK" : "Close"
        dispatch_async(dispatch_get_main_queue(), {
            self.rootView.hideLoadingView()
            let alertViewController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let action = result ? UIAlertAction(title: actionTitle, style: .Default, handler: {action -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)}) : UIAlertAction(title: actionTitle, style: .Default, handler: nil)
            
            alertViewController.addAction(action)
            
            self.presentViewController(alertViewController, animated: true, completion: nil)
        })
    }
    
    private func displayGeocodingError(error:NSError) {
        dispatch_async(dispatch_get_main_queue(), {
            self.rootView.hideLoadingView()
            
            let alertViewController: UIAlertController = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .Alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertViewController, animated: true, completion: nil)
        })
    }
}
