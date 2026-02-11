//
//  UserModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

struct AllUserTransactionApiResponse: Codable {
    var users: [AllUserTransactionModel]
}

struct AllUserTransactionModel: Codable {
    let id: String
    var balance: Double
    var transactions: [TransactionModel]
}
