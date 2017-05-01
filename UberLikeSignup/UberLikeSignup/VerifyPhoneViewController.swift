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
        
        let subTitle = "Please enter the verification code we sent to "
        let attributedString = NSMutableAttributedString(string: subTitle)
        let attributes : [String : Any] = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16), NSForegroundColorAttributeName : UIColor.black]
        attributedString.append(NSAttributedString(string: dataModel.phone, attributes: attributes))

        viewController.topAttributedSubTitle = attributedString
        
        viewController.viewType = .verify("")
        viewController.textDidChange = { [weak self] isValid in
            self?.changeButtonState(enable: isValid)
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
