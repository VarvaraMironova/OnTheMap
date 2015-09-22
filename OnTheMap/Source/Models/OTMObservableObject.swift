//
//  OTMObservableObject.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMObservableObject: NSObject {
    private var mutableObservers: NSMutableArray!
    var observers: NSArray {
        get {
            return mutableObservers.copy() as! NSArray
        }
    }
    
    override init () {
        mutableObservers = NSMutableArray()
    }
    
    func addObserver(observer: NSObject) {
        let weakObserver:OTMWeakLink = OTMWeakLink(target: observer)
        if !mutableObservers.containsObject(weakObserver) {
            mutableObservers.addObject(weakObserver)
        }
    }
    
    func removeObserver(observer: NSObject) {
        let weakObserver:OTMWeakLink = OTMWeakLink(target: observer)
        if mutableObservers.containsObject(weakObserver) {
            mutableObservers.removeObject(weakObserver)
        }
    }
    
    func notifyObserbers(selector: Selector, object: AnyObject) {
        let block: dispatch_block_t = {[weak self] in
            for observer in self!.mutableObservers {
                let weakObserver = observer as! OTMWeakLink
                if weakObserver.target.respondsToSelector(selector) {
                    let delay = 2.0 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue(), {
                        NSThread.detachNewThreadSelector(selector, toTarget:weakObserver.target, withObject:object)
                    })
                }
            }
        }
        
        dispatch_sync(dispatch_get_main_queue(), block)
    }
    
    func notifyObserbers(selector: Selector) {
        notifyObserbers(selector, object:self)
    }
}
