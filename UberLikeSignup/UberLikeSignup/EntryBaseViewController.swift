//
//  EntryBaseViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class EntryBaseViewController: UIViewController {

    var editController: EntryViewController?
    var dataModel = UserDataModel()
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnContinue.setTitle(NSLocalizedString("Continue", comment: ""), for: .normal)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: Notification.Name.UIKeyboardDidShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWasShown(notification: Notification) {
        
        guard let info: [AnyHashable:Any] = notification.userInfo,
            let keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }

        self.btnBottomMargin.constant = keyboardSize.height
    }

    func changeButtonState(enable: Bool) {
    
        if enable {
            btnContinue.isEnabled = true
            btnContinue.backgroundColor = #colorLiteral(red: 0.1580090225, green: 0.7655162215, blue: 0.3781598806, alpha: 1)
        } else {
            btnContinue.isEnabled = false
            btnContinue.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.9058823529, blue: 0.6470588235, alpha: 1)
        }

    }
    
    @IBAction func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EntryViewController" else {
            return
        }
        
        let vc = segue.destination as! EntryViewController
        editController = vc
        setupChildViewController(viewController: vc)
    }

}

/* ⚠️ Subclass must overide these functions */
extension EntryBaseViewController {

    func setupChildViewController(viewController: EntryViewController) {}
}

