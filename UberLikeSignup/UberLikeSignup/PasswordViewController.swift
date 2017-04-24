//
//  PasswordViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit
import SafariServices

class PasswordViewController: EntryBaseViewController  {

    @IBOutlet weak fileprivate var btnForgotPassword: UIButton!
    @IBOutlet weak fileprivate var btnSupport: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataModel.flowType == .signUp {
            btnForgotPassword.isHidden = true
            btnSupport.isHidden = true
        }
        else {
            btnForgotPassword.isHidden = false
            btnSupport.isHidden = false
        }
    }
    
    override func setupChildViewController(viewController: EntryViewController) {
        
        if dataModel.flowType == .signUp {
            viewController.topTitle = "Create password"
            viewController.topSubTitle = "It will be used to login your account, should be more than 6 letters"
        }
        else {
            viewController.topTitle = "Enter your password"
            viewController.topSubTitle = ""
        }
        
        viewController.viewType = .password("")
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }
    
    
    @IBAction func continueAction() {
        guard let editController = editController else {
            return
        }
        
        editController.textField.resignFirstResponder()

        let password = editController.viewType.value
        dataModel.password = password
        
        dump(dataModel)
        
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func forgotPasswordAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
        vc.dataModel.flowType = .forgotPassword
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func supportAction() {
        let tncUrl = URL(string: "http://www.example.com/")
        guard let url = tncUrl else {
            return
        }
        
        if #available(iOS 9.0, *) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
            present(vc, animated: true, completion: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
