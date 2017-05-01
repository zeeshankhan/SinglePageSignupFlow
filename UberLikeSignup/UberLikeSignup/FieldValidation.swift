//
//  FieldValidation.swift
//  UberLikeSignup
//
//  Created by Zeeshan Khan on 4/30/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import Foundation
import PhoneNumberKit

final class FieldValidation {

    static private var phoneNumberKit: PhoneNumberKit = {
        return PhoneNumberKit()
    }()
    
    
    static func currentLocationPhoneFormat() -> ViewType {
        let region = PhoneNumberKit.defaultRegionCode()
        if let code = phoneNumberKit.countryCode(for: region) {
            return .phone(imageCode: region, code: String(code), number: "")
        }
        return .phone(imageCode: "AE", code: "971", number: "")
    }
    
    static func isValidPhone(_ phone: String, forRegion region: String) -> Bool {
        do {
            _ = try phoneNumberKit.parse(phone, withRegion: region, ignoreType: false)
            
//            let phoneNumber = try phoneNumberKit.parse(phone, withRegion: region, ignoreType: false)
//            let number = phoneNumberKit.format(phoneNumber, toType: .national)
//            let country = String(phoneNumber.countryCode)
//            print("\(country) \(number)")
            
            return true
        }
        catch {
            return false
        }
    }

    // Just a formatted phone number, MIGHT not be valie phone number
    static func formattedPhone(region: String, number: String) -> String {
        let phoneFormatter = PartialFormatter.init(phoneNumberKit: phoneNumberKit, defaultRegion: region, withPrefix: true)
        let text = phoneFormatter.formatPartial(number)
        return text
    }
    
    // Return phone number if its valid: 052 123 4567
    static func validPhone(region: String, number: String) -> String {
        return validPhoneNumber(region: region, number: number, type: .national)
    }

    // Return phone number if its valid: +971 52 123 4567
    static func validPhoneWithCode(region: String, number: String) -> String {
        return validPhoneNumber(region: region, number: number, type: .international)
    }

    static private func validPhoneNumber(region: String, number: String, type: PhoneNumberFormat) -> String {
        do {
            let phoneNumber = try phoneNumberKit.parse(number, withRegion: region, ignoreType: false)
            let number = phoneNumberKit.format(phoneNumber, toType: type)
            return number
        }
        catch {
            return ""
        }
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    static func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }

}
