//
//  OTMConfig.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/11/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import Foundation

class OTMConfig: NSObject, NSCoding {
    
    // MARK: - Initialization
    
    override init() {}
    
    convenience init?(dictionary: [String : AnyObject]) {
        
        self.init()
        
        return nil
    }
    
    
    // MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
}
