//
//  OTMArrayObserver.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/1/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import Foundation

@objc protocol OTMArrayObserver {
    optional func arrayModelDidAddModel(arrayModel:OTMArrayModel, model:AnyObject)
    optional func arrayModelDidRemoveModelWithIndex(arrayModel:OTMArrayModel, index:Int)
}
