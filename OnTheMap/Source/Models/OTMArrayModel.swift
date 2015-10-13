//
//  OTMArrayModel.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMArrayModel: NSObject {
    var mutableModels = [OTMStudentLocationModel]()
    
    func addModel(model:OTMStudentLocationModel) {
        mutableModels.append(model)
    }
    
    func removeModel(model:OTMStudentLocationModel) {
        if containsObject(model) {
            mutableModels.removeAtIndex(indexOfObject(model))
        }
    }
    
    func objectAtIndex(index:Int) -> OTMStudentLocationModel {
        return mutableModels[index]
    }
    
    func indexOfObject(model: OTMStudentLocationModel) -> Int {
        var index = 0
        if containsObject(model) {
            index = mutableModels.indexOf({$0.uniqueKey == model.uniqueKey})!
        }
        
        return index
    }
    
    func containsObject(model: OTMStudentLocationModel) -> Bool {
        return mutableModels.contains({$0.uniqueKey == model.uniqueKey})
    }
    
    func count() -> Int {
        return mutableModels.count
    }
    
    func sort() {
        mutableModels.sortInPlace({$0.updateDate > $1.updateDate})
    }
    
}
