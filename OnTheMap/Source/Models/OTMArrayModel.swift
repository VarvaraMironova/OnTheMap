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
    var models: [OTMStudentLocationModel] {
        get {
            return mutableModels.copy() as! [OTMStudentLocationModel]
        }
    }
    
    override init () {
        mutableModels = NSMutableArray()
    }
    
    func addModel(model:OTMStudentLocationModel) {
        mutableModels.addObject(model)
        
        notifyObserbers(Selector("arrayModelDidAddModel:"), object:model)
    }
    
    func removeModel(model:OTMStudentLocationModel) {
        if mutableModels.containsObject(model) {
            let index = indexOfObject(model)
            mutableModels.removeObject(model)
            
            notifyObserbers(Selector("arrayModelDidRemoveModelWithIndex:"), object:index)
        }
    }
    
    func objectAtIndex(index:Int) -> AnyObject {
        return mutableModels.objectAtIndex(index)
    }
    
    func indexOfObject(object: AnyObject) -> Int {
        var index = 0
        if containsObject(object) {
            index = mutableModels.indexOfObject(object)
        }
        
        return index
    }
    
    func containsObject(object: AnyObject) -> Bool {
        return mutableModels.containsObject(object)
    }
    
    func count() -> Int {
        return mutableModels.count
    }
    
    func sort() {
        let sortedArray = models.sort({$0.updateDate > $1.updateDate})
        mutableModels = NSMutableArray(array: sortedArray)
    }
    
}
