//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/11/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import Foundation

class OTMClient: NSObject {
    var sharedSession: NSURLSession
    var sessionID    : String? = nil
    var userID       : String? = nil
    
    // MARK: - Class methods
    
    class func sharedInstance() -> OTMClient {
        struct Singleton {
            static var sharedInstance = OTMClient()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: - Initializations and Deallocations
    
    override init() {
        sharedSession = NSURLSession.sharedSession()
        super.init()
    }
    
    class func getRequest(baseUrl: String, method: String, headers: [String: String], parameters: [String: String]) -> NSMutableURLRequest {
        let url = NSURL(string: baseUrl + method + escapedParameters(parameters))
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "GET"
        request.timeoutInterval = 20.0;
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    class func postRequest(baseUrl: String, method: String, headers: [String: String], body: [String: AnyObject], parameters: [String: String]) -> NSMutableURLRequest {
        let url = NSURL(string: baseUrl + method + escapedParameters(parameters))
        
        let request = NSMutableURLRequest(URL: url!)
        
        request.addValue(OTMClient.kOTMConstants.kOTMJSON, forHTTPHeaderField: OTMClient.kOTMConstants.kOTMHeaderField1)
        request.addValue(OTMClient.kOTMConstants.kOTMJSON, forHTTPHeaderField: OTMClient.kOTMConstants.kOTMHeaderField2)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 20.0;
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(body, options:.PrettyPrinted)
            request.HTTPBody = jsonData
        } catch {
            // report error
        }
        
        return request
    }
    
    class func deleteRequest(baseUrl: String, method: String) -> NSMutableURLRequest {
        let url = NSURL(string: baseUrl + method)
        let request = NSMutableURLRequest(URL: url!)
        
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in (sharedCookieStorage.cookies )! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        request.HTTPMethod = "DELETE"
        request.timeoutInterval = 20.0;
        
        return request
    }
    
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        var urlVars = [String]()
        
        for (key, value) in parameters {
            let stringValue = "\(value)"
            
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }

    func createTask(request: NSMutableURLRequest, completionHandler: (result: NSData!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        let task = sharedSession.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError {
                completionHandler(result: nil, error: error)
            } else {
                completionHandler(result: data, error: nil)
            }
        }
        
        task.resume()
        
        return task
    }   
}
