//
//  CustomNavigationController.swift
//  UberLikeSignup
//
//  Created by Zeeshan Khan on 4/23/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = false
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        isNavigationBarHidden = true
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
