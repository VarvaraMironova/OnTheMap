//
//  OTMTableViewController.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/3/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMTableViewController: OTMLocationController, UITableViewDelegate, UITableViewDataSource {
    var rootView: OTMTableView! {
        get {
            if isViewLoaded() && self.view.isKindOfClass(OTMTableView) {
                return self.view as! OTMTableView
            } else {
                return nil
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModel.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OTMStudentInfoCell", forIndexPath: indexPath) as! OTMStudentInfoCell
        let model = arrayModel.objectAtIndex(indexPath.row) as! OTMStudentLocationModel
        
        cell.fillWithModel(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let studentModel = arrayModel.objectAtIndex(indexPath.row) as! OTMStudentLocationModel
        showStudentInfoInSafari(studentModel.url)
    }
}
