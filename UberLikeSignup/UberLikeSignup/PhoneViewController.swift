//
//  PhoneViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class PhoneViewController: EntryBaseViewController {

    override func setupChildViewController(viewController: EntryViewController) {
        viewController.viewType = .phone(imageCode: "AE", code: "971", number: "")
        viewController.didEndEditing = nil
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }


    @IBAction func continueAction() {
        
        guard let editController = editController else {
            return
        }
        
        if editController.viewType.value.characters.count < 11 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyPhoneViewController") as! VerifyPhoneViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            editController.modifyCellErrorState(isError: true)
        }
        
    }

    @IBAction override func backAction() {
        guard let editController = editController else {
            return
        }
        editController.textField.resignFirstResponder()
        dismiss(animated: true, completion:nil)
    }

}
