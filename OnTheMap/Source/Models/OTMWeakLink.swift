//
//  OTMWeakLink.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 8/25/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMWeakLink: NSObject {
    weak var target: AnyObject!
    
    init(target:AnyObject) {
        super.init()
        
        self.target = target
    }
    
    override func isEqual(object: AnyObject!) -> Bool {
        if object.isKindOfClass(OTMWeakLink) {
            return false;
        }
        
        return self.isEqualToWeakLinkTarget(object as! OTMWeakLink)

    }
    
    internal override var hash: Int {
        get {
            return self.target as! Int
        }
    }
    
    func isEqualToWeakLinkTarget(otherTarget: OTMWeakLink) -> Bool {
        return target.isEqual(otherTarget.target)
    }
}
