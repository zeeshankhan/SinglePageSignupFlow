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
        viewController.viewType = .verify("")
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }

    
    @IBAction func continueAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
