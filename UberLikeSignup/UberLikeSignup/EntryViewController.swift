//
//  EntryViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/8/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

typealias EntryViewCallback = ((_ item: ViewType) -> Void)

class EntryViewController: UIViewController {

    var viewType = ViewType.name("")

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var separator: UIView!       // Bottom separator view
    @IBOutlet weak var lblWarning: UILabel!     // Red warning label

    // Phone specific only
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblCode: UILabel!
    
    
    var isModified = false
    var textDidChange: EntryViewCallback?
    var didEndEditing: EntryViewCallback?
    var didBeginEditing: ((_ textField: UITextField) -> Void)?

    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        modifyCellErrorState(isError: viewType.isValid())
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    //MARK: Private functions
    func setupView() {

        lblTitle.text = viewType.title
        lblSubTitle.text = viewType.subtitle

        separator.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        lblWarning.text = ""

        if case .phone(let imgC, let code, _) = viewType {
            imgCountry.image = UIImage(named: imgC)
            lblCode.text = "+" + code
        }
        else {

            // Remove phone code view and add a left padding to text field as earlier it was with phone code.
            codeView.removeFromSuperview()
            let constraintButton = NSLayoutConstraint(item: textField,
                                                      attribute: NSLayoutAttribute.leading,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.leading,
                                                      multiplier: 1,
                                                      constant: 20)
            view.addConstraint(constraintButton)
            view.layoutIfNeeded()
        }
        
        setupTextField()
    }
    
    func modifyCellErrorState(isError: Bool) {
        if isModified == false { return }
        if isError {
            separator.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            lblWarning.text = viewType.warningMessage()
        }
        else {
            separator.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
            lblWarning.text = ""
        }
    }
    

    //MARK: IBActions
    
    @IBAction func phoneCodeAction() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryListVC") as! CountryListVC
        vc.didSelectCountry = { [weak self] (code) in
            
            //print("Code: \(code) \(indexPath) \(item)")
            self?.viewType = ViewType.phone(imageCode: code[kCountryFlag]!, code: code[kPhoneCode]!, number: (self?.viewType.value)!)
            self?.imgCountry.image = UIImage(named: code[kCountryFlag]!)
            self?.lblCode.text = "+" + code[kPhoneCode]!
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension EntryViewController : UITextFieldDelegate {

    func setupTextField() {
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        textField.placeholder = viewType.placeholder
        textField.keyboardType = viewType.keyboard
        textField.isSecureTextEntry = viewType.isSecure
        textField.text = viewType.value
        textField.becomeFirstResponder()
        
        if let callback = textDidChange {
            callback(self.viewType)
        }
    }

    // Called from addTarget selector on UIControlEvents.editingChanged
    func textFieldDidChange(_ textField: UITextField) {
        isModified = viewType.shouldValidate
        modifyCellErrorState(isError: false)
        if let callback = textDidChange {
            viewType = viewType.new(textField.text!)
            callback(self.viewType)
        }
    }

    //MARK: UITextField delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        separator.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        if let callback = didEndEditing {
            viewType = viewType.new(textField.text!)
            callback(viewType)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        separator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblWarning.text = ""
        if let callback = didBeginEditing {
            callback(textField)
        }
    }
}
