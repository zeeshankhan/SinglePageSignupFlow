//
//  PasswordViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class PasswordViewController: EntryBaseViewController  {

    override func setupChildViewController(viewController: EntryViewController) {
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
        dismiss(animated: true, completion: nil)
    }

}
