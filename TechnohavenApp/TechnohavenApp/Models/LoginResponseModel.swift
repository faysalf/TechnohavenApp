//
//  LoginResponseModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

struct AllUserLoginResponseModel: Codable {
    let usersLogin: [UserInfo]
}

struct UserInfo: Codable {
    let id: String
    let fullName: String
    let email: String
    let password: String
    var balance: Double
}

