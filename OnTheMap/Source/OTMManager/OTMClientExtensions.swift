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
    
    func loginWithFB (email:String, password:String, completionHandler:(success: Bool, errorString: String?) -> Void) {
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
    
    func logout(completionHandler:(success: Bool, errorString: String?) -> Void) {
        let logoutRequest = OTMClient.deleteRequest(kOTMURLs.Udacity, method: kOTMMethods.Session)
        createTask(logoutRequest){data, error in
            if (nil != error) {
                completionHandler(success: false, errorString: kOTMMessages.ConnectionFailure)
            } else {
                let logoutData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                do {
                    let responseDictionary = try NSJSONSerialization.JSONObjectWithData(logoutData, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                    if let session = responseDictionary["session"] as? [String : String] {
                        if let sessionID = session["id"] as String! {
                            print(sessionID, self.sessionID)
                            completionHandler(success: true, errorString: nil)
                        }
                    } else {
                        completionHandler(success: false, errorString: kOTMMessages.NoJsonFailure)
                    }
                } catch {
                    completionHandler(success: false, errorString: kOTMMessages.ReadJsonFailure)
                }
            }
        }
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
                                
                                if let session = responseDictionary["session"] as? [String : String] {
                                    if let sessionID = session["id"] as String! {
                                        self.sessionID = sessionID
                                    }
                                }
                                    
                                self.userID = userModel.uniqueKey
                                
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
                        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                            if let userModel = appDelegate.userModel as OTMUserModel! {
                                userModel.fill(responseDictionary)
                            }
                        }
                        
                        handler(success: true, error: nil)
                    }
                } catch {
                    handler(success: false, error: kOTMMessages.ReadJsonFailure)
                }
            }
        }
    }
    
    func getLocations(completionHandler: (success: Bool, error: String?) -> Void) {
        let parameters = ["limit": OTMClient.kOTMHeaderConstants.kOTMLimit]
        let locations = OTMArrayModel()
        let headers = [OTMClient.kOTMHeaderConstants.kOTMParseIdKey: OTMClient.kOTMKeys.ParseAppID,
                       OTMClient.kOTMHeaderConstants.kOTMParseRestApiKey: OTMClient.kOTMKeys.ParseAPIKey]
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
                    completionHandler(success: false, error: kOTMMessages.ReadJsonFailure)
                }
            }
        }
    }
    
    func postStudentInfo(completionHandler: (success: Bool, error: String?) -> Void) {
        let headers = [OTMClient.kOTMHeaderConstants.kOTMParseIdKey: OTMClient.kOTMKeys.ParseAppID,
                       OTMClient.kOTMHeaderConstants.kOTMParseRestApiKey: OTMClient.kOTMKeys.ParseAPIKey]
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let userModel = appDelegate.userModel as OTMUserModel! {
                let body = [
                    "uniqueKey": userModel.uniqueKey,
                    "firstName": userModel.firstName,
                    "lastName": userModel.lastName,
                    "mapString": userModel.mapString,
                    "mediaURL": userModel.url!.absoluteString,
                    "latitude": NSNumber(double: userModel.annotation.coordinate.latitude),
                    "longitude": NSNumber(double: userModel.annotation.coordinate.longitude)
                ]
                
                let postInfoRequest = OTMClient.postRequest(OTMClient.kOTMURLs.Parse, method: OTMClient.kOTMMethods.StudentLocation, headers: headers, body:body, parameters: [String:String]())
                createTask(postInfoRequest) {data, error in
                    if nil != error {
                        completionHandler(success: false, error: kOTMMessages.ConnectionFailure)
                    } else {
                        do {
                            let response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                            if let error = response["error"] as? String {
                                completionHandler(success: false, error:error)
                            } else {
                                if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                                    if let userModel = appDelegate.userModel as OTMUserModel! {
                                        userModel.objectId = response["objectId"] as! String
                                        
                                        let dateFormatter = NSDateFormatter()
                                        dateFormatter.dateFormat = OTMModelConstants.DateFormatter
                                        userModel.updateDate = dateFormatter.dateFromString(response["createdAt"] as! String)
                                    }
                                }
                                
                                completionHandler(success: true, error: kOTMMessages.PostSuccess)
                            }
                        } catch {
                            completionHandler(success: false, error: kOTMMessages.ReadJsonFailure)
                        }
                    }
                }
            }
        }
    }
    
    func updateStudentInfo(completionHandler: (success: Bool, error: String?) -> Void) {
        let headers = [OTMClient.kOTMHeaderConstants.kOTMParseIdKey: OTMClient.kOTMKeys.ParseAppID,
            OTMClient.kOTMHeaderConstants.kOTMParseRestApiKey: OTMClient.kOTMKeys.ParseAPIKey]
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if let userModel = appDelegate.userModel as OTMUserModel! {
                let body = [
                    "uniqueKey": userModel.uniqueKey,
                    "firstName": userModel.firstName,
                    "lastName": userModel.lastName,
                    "mapString": userModel.mapString,
                    "mediaURL": userModel.url!.absoluteString,
                    "latitude": NSNumber(double: userModel.annotation.coordinate.latitude),
                    "longitude": NSNumber(double: userModel.annotation.coordinate.longitude)
                ]
                
                let postInfoRequest = OTMClient.putRequest(OTMClient.kOTMURLs.Parse, method: OTMClient.kOTMMethods.StudentLocation, headers: headers, body:body, parameters: [String:String]())
                createTask(postInfoRequest) {data, error in
                    if nil != error {
                        completionHandler(success: false, error: kOTMMessages.ConnectionFailure)
                    } else {
                        do {
                            let response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                            if let error = response["error"] as? String {
                                completionHandler(success: false, error:error)
                            } else {
                                if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                                    if let userModel = appDelegate.userModel as OTMUserModel! {
                                        userModel.objectId = response["objectId"] as! String
                                        
                                        let dateFormatter = NSDateFormatter()
                                        dateFormatter.dateFormat = OTMModelConstants.DateFormatter
                                        userModel.updateDate = dateFormatter.dateFromString(response["updatedAt"] as! String)
                                    }
                                }
                                
                                completionHandler(success: true, error: kOTMMessages.PostSuccess)
                            }
                        } catch {
                            completionHandler(success: false, error: kOTMMessages.ReadJsonFailure)
                        }
                    }
                }
            }
        }
    }
}
