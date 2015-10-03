//
//  OTMLoginViewController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/3/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMLoginViewController: UIViewController, UITextFieldDelegate {
    
    var rootView: OTMLoginView! {
        get {
            if isViewLoaded() && self.view.isKindOfClass(OTMLoginView) {
                return self.view as! OTMLoginView
            } else {
                return nil
            }
        }
    }
    
    var userModel: OTMUserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            userModel = appDelegate.userModel
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        rootView.endEditing(true);
    }

    @IBAction func onLogInButton(sender: AnyObject) {
        rootView.endEditing(true);
        
        rootView.showLoadingView()
        
        OTMClient.sharedInstance().login(userModel.login, password: userModel.password) {success, errorString in
            if success {
                OTMClient.sharedInstance().getLocations(){success, error in
                    if success {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.rootView.hideLoadingView()
                            
                            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                            self.presentViewController(controller, animated: true, completion: nil)
                        })
                    } else {
                        self.displayError(error!)
                    }
                }
            } else {
                self.displayError(errorString!)
            }
        }
    }
    
    // MARK: - Interface handling
    
    @IBAction func onLoginWithFBButton(sender: AnyObject) {
        
    }

    // MARK: - Private
    
    func displayError(error:String) {
        dispatch_async(dispatch_get_main_queue(), {
            self.rootView.hideLoadingView()
            
            let alertViewController: UIAlertController = UIAlertController(title: "Oops!", message: error, preferredStyle: .Alert)
            alertViewController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertViewController, animated: true, completion: nil)
        })
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch (textField.tag) {
            //login TextField
        case 1:
            userModel.login = textField.text;
            break
            
            //password TextField
        case 2:
            userModel.password = textField.text;
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
    
}
