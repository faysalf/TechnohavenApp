//
//  TransactionModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

struct TransactionModel: Codable, Identifiable {
    let id: String
    let date: Date
    let title: String
    let amount: Double
}
