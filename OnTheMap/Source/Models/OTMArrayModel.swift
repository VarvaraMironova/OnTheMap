//
//  OTMArrayModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMArrayModel: OTMObservableObject {
    private var mutableModels: NSMutableArray!
    var models: NSArray {
        get {
            return mutableModels.copy() as! NSArray
        }
    }
    
    override init () {
        mutableModels = NSMutableArray()
    }
    
    

}
