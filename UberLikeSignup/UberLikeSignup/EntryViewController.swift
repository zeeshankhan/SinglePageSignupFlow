//
//  EntryViewController.swift
//  SignupPOC
//
//  Created by Zeeshan Khan on 4/8/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    var viewType = ViewType.name("")
    var topTitle = ""
    var topSubTitle = ""
    var topAttributedSubTitle: NSAttributedString?

    @IBOutlet weak fileprivate var lblTitle: UILabel!
    @IBOutlet weak fileprivate var lblSubTitle: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak fileprivate var separator: UIView!       // Bottom separator view
    @IBOutlet weak fileprivate var lblWarning: UILabel!     // Red warning label

    // Phone specific only
    @IBOutlet weak fileprivate var codeView: UIView!
    @IBOutlet weak fileprivate var imgCountry: UIImageView!
    @IBOutlet weak fileprivate var lblCode: UILabel!
    
    var isModified = false
    var textDidChange: ((_ isValidEntry: Bool) -> Void)?
    var didEndEditing: ((_ item: ViewType) -> Void)?
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
        textField.autocorrectionType = viewType.autocorrectionType
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//    }
    
    //MARK: Private functions
    func setupView() {

        lblTitle.text = topTitle
        
        if let topAttributedSubTitle = topAttributedSubTitle {
            lblSubTitle.attributedText = topAttributedSubTitle
        }
        else {
            lblSubTitle.text = topSubTitle
        }

        separator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
            separator.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.2431372549, blue: 0.3215686275, alpha: 1)
            lblWarning.text = viewType.warningMessage()
        }
        else {
            separator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
            
            let text = FieldValidation.validPhone(region: code[kCountryFlag]!, number: (self?.viewType.value)!)
            let isValid = FieldValidation.isValidPhone(text, forRegion: code[kCountryFlag]!)
            if let callback = self?.textDidChange {
                callback(isValid)
            }

        }
        let navCont = UINavigationController(rootViewController: vc)
        present(navCont, animated: true, completion: nil)
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
            callback(self.viewType.isValid())
        }
    }
    
    // Called from addTarget selector on UIControlEvents.editingChanged
    func textFieldDidChange(_ textField: UITextField) {
        
        var text = textField.text!
        
        if case .phone(let regionCode, _, _) = viewType {
            textField.text = FieldValidation.formattedPhone(region: regionCode, number: text)
            text = FieldValidation.validPhone(region: regionCode, number: text)
        }
        
        isModified = viewType.shouldValidate
        modifyCellErrorState(isError: false)

        let isValid = viewType.isValidText(text)

        if isValid {
            viewType = viewType.new(text)
        }
        
        if let callback = textDidChange {
            callback(isValid)
        }
    }

    //MARK: UITextField delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        if case .phone = viewType {
            if string.characters.count == 1 && string == "+" {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        separator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewType = viewType.new(textField.text!)
        if let callback = didEndEditing {
            callback(viewType)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false //textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        separator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lblWarning.text = ""
        if let callback = didBeginEditing {
            callback(textField)
        }
    }
}
