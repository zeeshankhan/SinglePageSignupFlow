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
        viewController.viewType = .email("")
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }
    
    
    @IBAction func continueAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
