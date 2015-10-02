//
//  OTMConstants.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/11/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

extension OTMClient {
    
    struct kOTMKeys{
        static let ParseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let FaceboorId  = "365362206864879"
    }
    
    
    struct kOTMURLs {
        static let Parse = "https://api.parse.com/"
        static let Udacity = "https://www.udacity.com/"
    }
    
    struct kOTMMethods {
        static let StudentLocation = "1/classes/StudentLocation"
        static let Session = "api/session"
        static let UserData = "api/users/{id}"
    }
    
    struct kOTMMessages {
        static let ConnectionFailure = "Connection failure. Please, try again later"
        static let ReadJsonFailure   = "JSON does not contain a dictionary"
        static let NoJsonFailure     = "JSON failed"
    }
    
    struct kOTMConstants {
        static let kOTMJSON         = "application/json"
        static let kOTMHeaderField1 = "Accept"
        static let kOTMHeaderField2 = "Content-Type"
    }
}
