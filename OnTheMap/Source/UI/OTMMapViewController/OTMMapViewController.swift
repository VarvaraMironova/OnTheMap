//
//  OTMMapViewController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/3/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import MapKit

class OTMMapViewController: OTMLocationController, MKMapViewDelegate {
    override var rootView: OTMMapView! {
        get {
            if isViewLoaded() && self.view.isKindOfClass(OTMMapView) {
                return self.view as! OTMMapView
            } else {
                return nil
            }
        }
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(MKUserLocation) {
            return nil;
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
        
        if nil == annotationView {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView!.canShowCallout = true
            
        }
        
        annotationView!.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure)
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation as! OTMAnnotationModel? {
                if let url = NSURL(string: annotation.subtitle!) {
                    showStudentInfoInSafari(url)
                }
            }
        }
    }
    
    override func reloadData() {
        super.reloadData()
        
        let mapView = self.rootView.mapView as MKMapView
        
        mapView.removeAnnotations(mapView.annotations)
        
        for studentModel in self.arrayModel.mutableModels {
            mapView.addAnnotation(studentModel.annotation)
        }
    }

}
