//
//  OTMLocationController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/29/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMLocationController: UIViewController {
    var userModel: OTMUserModel!
    var arrayModel : OTMArrayModel = OTMArrayModel()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            arrayModel = appDelegate.locations!
            userModel = appDelegate.userModel
        }
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        OTMClient.sharedInstance().logout() {success, error in
            dispatch_async(dispatch_get_main_queue(), {
                if success {
                    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! OTMLoginViewController
                    self.presentViewController(controller, animated: true, completion: nil)
                } else {
                    self.displayError(error!)
                }
            })
        }
    }
    
    @IBAction func onPostLocationButton(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            // check if there is a location user posted -> show alert, else -> post location
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PostLocationViewController") as!OTMPostLocationViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }

    func showStudentInfoInSafari(url: NSURL) {
        let app = UIApplication.sharedApplication()
        if app.canOpenURL(url) {
            app.openURL(url)
        }
    }
    
    private func displayError(error:String) {
        let alertViewController: UIAlertController = UIAlertController(title: "Oops!", message: error, preferredStyle: .Alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }

}
