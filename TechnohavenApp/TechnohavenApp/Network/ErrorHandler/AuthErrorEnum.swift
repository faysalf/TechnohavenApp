//
//  AuthErrorEnum.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

enum AuthErrorEnum: LocalizedError {
    case invalidEmail
    case passwordShortage
    case invalid

    var description: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email."
        case .passwordShortage:
            return "Password must be at least 6 characters."
        case .invalid:
            return "Invalid email or password."
        }
    }
}
