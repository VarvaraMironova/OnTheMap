//
//  OTMLoginView.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/3/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMLoginView: UIView {
    @IBOutlet var logInWithFBButton: UIButton!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var loadingView: OTMLoadingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateButtons()
    }
    
    func updateButtons() {
        logInButton.enabled = !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty;
    }
    
    func showLoadingView() {
        loadingView = OTMLoadingView.loadingView(self)
    }
    
    func hideLoadingView() {
        loadingView.hide()
        loadingView = nil
    }

}
