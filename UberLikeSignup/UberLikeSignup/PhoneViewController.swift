//
//  PhoneViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneViewController: EntryBaseViewController {

    override func setupChildViewController(viewController: EntryViewController) {
        viewController.topTitle = "Enter your mobile number"
        viewController.topSubTitle = "Will be used to confirm your account"
        
        viewController.viewType = FieldValidation.currentLocationPhoneFormat()
        viewController.textDidChange = { [weak self] isValid in
            self?.changeButtonState(enable: isValid)
        }
    }


    @IBAction func continueAction() {
        
        guard let editController = editController else {
            return
        }
        
        let viewType = editController.viewType
        var phone = ""
        if case .phone(let region, _, let number) = viewType {
            phone = FieldValidation.validPhoneWithCode(region: region, number: number)
        }
        
//        guard phone.characters.count == 12 else {
//            editController.modifyCellErrorState(isError: true)
//            return
//        }
        
        var vc: EntryBaseViewController
        
        if phone != "+971 52 609 7571" {
            dataModel.flowType = .signUp
            dataModel.phone = phone
            
            vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPhoneViewController") as! VerifyPhoneViewController
            vc.dataModel = dataModel
        }
        else {
            dataModel.flowType = .signIn
            dataModel.phone = phone

            vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            vc.dataModel = dataModel
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func cancelAction() {
        guard let editController = editController else {
            return
        }
        editController.textField.resignFirstResponder()
        dismiss(animated: true, completion:nil)
    }

}
