//
//  ViewController.swift
//  UberLikeSignup
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneContainerView: UIView! {
        didSet {
            phoneContainerView.layer.cornerRadius =  4.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "POC"
    }
    
    @IBAction func presentNewSignUp() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
        let navCont = CustomNavigationController(rootViewController: vc)
        present(navCont, animated: true, completion: nil)
    }

}

