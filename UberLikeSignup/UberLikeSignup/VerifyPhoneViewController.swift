//
//  VerifyPhoneViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/15/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class VerifyPhoneViewController: EntryBaseViewController {

    override func setupChildViewController(viewController: EntryViewController) {
        viewController.topTitle = "Verify Account"
        viewController.topSubTitle = "Please enter the verification code we sent to your phone"
        viewController.viewType = .verify("")
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }

    
    @IBAction func continueAction() {
        guard let editController = editController else {
            return
        }
        
        let verify = editController.viewType.value
        dataModel.verify = verify

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        vc.dataModel = dataModel
        navigationController?.pushViewController(vc, animated: true)
    }

}
