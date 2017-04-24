//
//  UserDataModel.swift
//  UberLikeSignup
//
//  Created by Zeeshan Khan on 4/24/17.
//  Copyright © 2017 Zeeshan Khan. All rights reserved.
//

import Foundation

struct UserDataModel {
    
    enum FlowType {
        case signUp, signIn, forgotPassword, facebook
    }
    
    var flowType: FlowType = .signUp
    var items: [ViewType] = []
    var phone = ""
    var name = ""
    var email = ""
    var password = ""
    var verify = ""
}
