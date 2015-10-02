//
//  OTMClientExtensions.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/11/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit
import Foundation

extension OTMClient {
    func login(email:String, password:String, completionHandler:(success: Bool, errorString: String?) -> Void) {
        getUserId(email, password: password, completionHandler: {success, errorString in
            if success {
                self.getUserInfo(self.userID!, handler: {success, error in
                    if success {
                        completionHandler(success: true, errorString: nil)
                    } else {
                        completionHandler(success: false, errorString: error)
                    }
                })
            } else {
                completionHandler(success: false, errorString:errorString)
            }
        })
    }
    
    func getUserId(email:String, password:String, completionHandler:(success: Bool, errorString: String?) -> Void) {
        let body = ["udacity": [ "username": email, "password": password]]
        let parameters = [String:String]()
        let headers = [String: String]()
        let loginRequest = OTMClient.postRequest(kOTMURLs.Udacity, method: kOTMMethods.Session, headers:headers, body: body, parameters: parameters)
        createTask(loginRequest){data, error in
            if (nil != error) {
                completionHandler(success: false, errorString: kOTMMessages.ConnectionFailure)
            } else {
                let authData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                do {
                    let responseDictionary = try NSJSONSerialization.JSONObjectWithData(authData, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    if let error = responseDictionary["error"] as? String {
                        completionHandler(success: false, errorString: error)
                    } else {
                        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                            if let userModel = appDelegate.userModel as OTMUserModel! {
                                userModel.fill(responseDictionary)
                                self.userID = userModel.key
                                completionHandler(success: true, errorString: nil)
                            } else {
                                completionHandler(success: false, errorString: "Cannot get userID")
                            }
                        }
                    }
                } catch {
                    completionHandler(success: false, errorString: kOTMMessages.ReadJsonFailure)
                }
            }
        }
    }
    
    func getUserInfo(userID: String, handler: (success: Bool, error: String?) -> Void) {
        let parameters = [String:String]()
        let method = OTMClient.kOTMMethods.UserData.stringByReplacingOccurrencesOfString("{id}", withString: userID, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        let headers = [String: String]()
        let loginRequest = OTMClient.getRequest(kOTMURLs.Udacity, method: method, headers:headers, parameters: parameters)
        
        createTask(loginRequest){data, error in
            if (nil != error) {
                handler(success: false, error: kOTMMessages.ConnectionFailure)
            } else {
                let authData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                do {
                    let responseDictionary = try NSJSONSerialization.JSONObjectWithData(authData, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    if let error = responseDictionary["error"] as? String {
                        handler(success: false, error: error)
                    } else {
                        self.fillUserModel(responseDictionary)
                        
                        handler(success: true, error: nil)
                    }
                } catch {
                    handler(success: false, error: kOTMMessages.ReadJsonFailure)
                }
            }
        }
    }
    
    func fillUserModel(jsonResponse: [String: AnyObject]) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            let user = appDelegate.userModel
            let userResponse = jsonResponse["user"] as! [String: AnyObject]
            user?.name = userResponse["first_name"] as! String
            user?.surName = userResponse["last_name"] as! String
            
            appDelegate.userModel = user
        }
    }
    
    func getLocations(completionHandler: (success: Bool, error: String?) -> Void) {
        let parameters = ["limit": "200"]
        let locations = OTMArrayModel()
        let headers = ["X-Parse-Application-Id": OTMClient.kOTMKeys.ParseAppID,
                       "X-Parse-REST-API-Key": OTMClient.kOTMKeys.ParseAPIKey]
        let getInfoRequest = OTMClient.getRequest(OTMClient.kOTMURLs.Parse, method: OTMClient.kOTMMethods.StudentLocation, headers: headers, parameters: parameters)
        createTask(getInfoRequest){data, error in
            if nil != error {
                completionHandler(success: false, error: kOTMMessages.ConnectionFailure)
            } else {
                do {
                    let response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    if let error = response["error"] as? String {
                        completionHandler(success: false, error:error)
                    } else {
                        let results = response["results"] as! [[String: AnyObject]]
                        for result in results {
                            if let studentLocationModel = OTMStudentLocationModel(result: result) as OTMStudentLocationModel? {
                                locations.addModel(studentLocationModel)
                            }
                        }
                        
                        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate{
                            locations.sort()
                            
                            appDelegate.locations = locations
                        }
                        
                        completionHandler(success: true, error:nil)
                    }
                } catch {
                    
                }
            }
        }
    }
    
//    func POSTStudentInformation(body: [String: AnyObject], completionHandler: (success: Bool, error: String?) -> Void) {
//        var headers = buildHeaders()
//        var postInfoRequest = APIHelper.postRequest(APIHelper.BaseURLs.MapAPI, api: APIHelper.APIs.StudentLocation, body: body, headers: headers, queryString: [:])
//        var task = APIHelper.buildTask(postInfoRequest) { (data, error) in
//            if let e = error {
//                completionHandler(success: false, error: "There was an issue contacting the server")
//            } else {
//                let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String: AnyObject]
//                if let error = response!["error"] as? String{
//                    completionHandler(success: false, error: error)
//                } else {
//                    completionHandler(success: true, error: nil)
//                }
//                
//            }
//        }
//    }
}
