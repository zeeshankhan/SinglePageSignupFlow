//
//  NameViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class NameViewController: EntryBaseViewController {

    override func setupChildViewController(viewController: EntryViewController) {
        viewController.viewType = .name("")
        viewController.textDidChange = { [weak self] viewType in
            self?.changeButtonState(enable: viewType.isValid())
        }
    }
    
    
    @IBAction func continueAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
