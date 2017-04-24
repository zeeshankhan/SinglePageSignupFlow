//
//  ViewType.swift
//  ZKSignup
//
//  Created by Zeeshan Khan on 2/25/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import Foundation
import UIKit

let kCountryFlag        = "code"
let kPhoneCode          = "country_code"
let kPhoneNumber        = "number"

enum ViewType {
    case name(String)
    case email(String)
    case password(String)
    case phone(imageCode: String, code: String, number: String)
    case invitationCode(String)
    case verify(String)

    var value: String {
        switch self {
        case .name(let n): return n
        case .email(let e): return e
        case .password(let p): return p
        case .phone(_, _, let n): return n
        case .invitationCode(let i): return i
        case .verify(let v): return v
        }
    }

    func new(_ value: String) -> ViewType {
        switch self {
        case .name: return .name(value)
        case .email: return .email(value)
        case .password: return .password(value)
        case .phone(let imgC, let c, _): return .phone(imageCode: imgC, code: c, number: value)
        case .invitationCode: return .invitationCode(value)
        case .verify: return .verify(value)
        }
    }

    var keyboard: UIKeyboardType {
        switch self {
        case .name: return .namePhonePad
        case .email: return .emailAddress
        case .password: return .default
        case .phone: return .phonePad
        case .invitationCode: return .default
        case .verify: return .phonePad
        }
    }

    var placeholder: String {
        switch self {
        case .name: return "full name"
        case .email: return "name@example.com"
        case .password: return "password"
        case .phone: return "50 123 4567"
        case .invitationCode: return "Invitation Code (Optional)"
        case .verify: return "1234"
        }
    }

    var iconName: String {
        switch self {
        case .name: return "nameIcon"
        case .email: return "emailIcon"
        case .password: return "passwordIcon"
        case .phone: return "phoneIcon"
        case .invitationCode: return "giftIcon"
        case .verify: return ""
        }
    }

    var isSecure: Bool {
        if case .password(_) = self {
            return true
        }
        return false
    }

    var shouldValidate: Bool {
        switch self {
        case .invitationCode: return false
        default: return true
        }
    }

    func isValid() -> Bool {
        return isValidText(self.value)
    }
    
    func isValidText(_ text: String) -> Bool {
        switch self {
        case .name: return text.isValidName()
        case .email: return text.isValidEmail()
        case .password: return text.characters.count > 5
        case .phone: return text.characters.count > 8 //text.isValidPhone()
        case .invitationCode: return true //text.characters.count > 5
        case .verify: return text.characters.count == 4
        }
    }

    func warningMessage() -> String {
        switch self {
        case .name: return "Please fill in your name."
        case .email: return self.value.isEmpty ? "Please fill in your email." : "Invalid email format."
        case .password: return self.value.isEmpty ? "Please fill in your password." : "Password should be 6 characters long."
        case .phone: return self.value.isEmpty ? "Please fill in your phone." : "Invalid phone number."
        case .invitationCode: return ""
        case .verify: return "Invalid code"
        }
    }    
}

