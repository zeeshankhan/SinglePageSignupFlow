//
//  EmailViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class EmailViewController: EntryBaseViewController {

    override func setupChildViewController(viewController: EntryViewController) {
        
        if dataModel.flowType == .signUp {
            viewController.topTitle = "Enter your email address"
            viewController.topSubTitle = "Email will be used to receive trip receipt and promotions and special offers"
        }
        else if dataModel.flowType == .signIn {
             // why we'll come here in case of email as phone number is primary key for entering...
        }
        else if dataModel.flowType == .forgotPassword {
            viewController.topTitle = "Enter your email address"
            viewController.topSubTitle = "Email will send a rest link to your email"
        }
        
        viewController.viewType = .email("")
        viewController.textDidChange = { [weak self] isValid in
            self?.changeButtonState(enable: isValid)
        }
    }
    
    
    @IBAction func continueAction() {
        guard let editController = editController else {
            return
        }
        
        let email = editController.viewType.value
        dataModel.email = email
        
        if dataModel.flowType == .forgotPassword {
            editController.textField.resignFirstResponder()
            dump(dataModel)
            dismiss(animated: true, completion: nil)
        }
        else { // Sign up
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            vc.dataModel = dataModel
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
