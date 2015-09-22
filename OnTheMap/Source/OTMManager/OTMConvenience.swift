//
//  OTMConvenience.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/11/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import Foundation

extension OTMClient {
    
//    func getSessionID(requestToken: String?, completionHandler: (success: Bool, sessionID: String?, errorString: String?) -> Void) {
//        
//        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        var parameters = [TMDBClient.ParameterKeys.RequestToken : requestToken!]
//        
//        /* 2. Make the request */
//        taskForGETMethod(Methods.AuthenticationSessionNew, parameters: parameters) { JSONResult, error in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                completionHandler(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
//            } else {
//                if let sessionID = JSONResult.valueForKey(TMDBClient.JSONResponseKeys.SessionID) as? String {
//                    completionHandler(success: true, sessionID: sessionID, errorString: nil)
//                } else {
//                    completionHandler(success: false, sessionID: nil, errorString: "Login Failed (Session ID).")
//                }
//            }
//        }
//    }
//    
//    
//    
//    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
//    request.HTTPMethod = "POST"
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.HTTPBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".dataUsingEncoding(NSUTF8StringEncoding)
//    let session = NSURLSession.sharedSession()
//    let task = session.dataTaskWithRequest(request) { data, response, error in
//        if error != nil { // Handle error…
//            return
//        }
//        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
//        println(NSString(data: newData, encoding: NSUTF8StringEncoding))
//    }
//    task.resume()
    
}
