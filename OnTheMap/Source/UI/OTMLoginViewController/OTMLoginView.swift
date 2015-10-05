//
//  OTMLoginView.swift
//  OnTheMap
//
//  Created by Varvara Mironova on 9/3/15.
//  Copyright (c) 2015 VarvaraMironova. All rights reserved.
//

import UIKit

class OTMLoginView: OTMView {
    @IBOutlet var textFieldsContainer: UIView!
    @IBOutlet var logInWithFBButton: UIButton!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateButtons()
    }
    
    func updateButtons() {
        logInButton.enabled = !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
    }
    
    func shakeLoginContainer() {
        textFieldsContainer.shake()
    }
    
}
