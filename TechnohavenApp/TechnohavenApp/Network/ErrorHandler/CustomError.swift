//
//  CustomError.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

enum CustomError: Error {
    case error(message: String, code: Int)
}

func extractErrorMessage(_ error: Error)-> (message: String, code: Int) {
    if let myError = error as? CustomError {
        switch myError {
        case .error(let message, let code):
            return (message, code)
        }
    } else {
        return ("Something went wrong!", 0)
    }
    
}

