//
//  OTMLocationController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/29/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMLocationController: UIViewController, OTMArrayObserver {
    var arrayModel : OTMArrayModel = OTMArrayModel() {
        didSet {
            self.arrayModel.removeObserver(self)
            arrayModel.addObserver(self)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            arrayModel = appDelegate.locations!
        }
    }
    
    func arrayModelDidAddModel(arrayModel:OTMArrayModel, model:AnyObject) {
        
    }
    
    func arrayModelDidRemoveModelWithIndex(arrayModel:OTMArrayModel, index:Int) {
        
    }
    
    func showStudentInfoInSafari(url: NSURL) {
        let app = UIApplication.sharedApplication()
        if app.canOpenURL(url) {
            app.openURL(url)
        }
    }

}
