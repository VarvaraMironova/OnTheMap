//
//  OTMDateExtensions.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 10/1/15.
//  Copyright © 2015 VarvaraMironova. All rights reserved.
//

import Foundation

extension NSDate : Comparable {}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending &&
        !lhs.isEqualToDate(rhs)
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}
