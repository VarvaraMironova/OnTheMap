//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window   : UIWindow?
    var userModel: OTMUserModel?
    var locations: OTMArrayModel?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        userModel = OTMUserModel()
        
        return true
    }

}

