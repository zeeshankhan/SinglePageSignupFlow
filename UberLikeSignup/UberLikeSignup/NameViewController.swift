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
        viewController.topTitle = "Enter your full name"
        viewController.topSubTitle = "To know what to call you and help your captain communicate with you"
        viewController.viewType = .name("")
        viewController.textDidChange = { [weak self] isValid in
            self?.changeButtonState(enable: isValid)
        }
    }
    
    
    @IBAction func continueAction() {
        guard let editController = editController else {
            return
        }
        
        let name = editController.viewType.value
        dataModel.name = name
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
        vc.dataModel = dataModel
        navigationController?.pushViewController(vc, animated: true)
    }

}
