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

        userModel = OTMUserModel()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        rootView.endEditing(true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogInButton(sender: AnyObject) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"v.mironova@gmail.com\", \"password\": \"Kl77nVtq\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
    
    @IBAction func onSignUpButton(sender: AnyObject) {
        
    }
    
    @IBAction func onLoginWithFBButton(sender: AnyObject) {
        
    }

    @IBAction func onLogOutButton(sender: AnyObject) {
        
    }
    
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
