//
//  SendMoneyService.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

final class SendMoneyService: SendMoneyServiceProtocol {
    
    private let client = NetworkClient()
    
    func sendMoney(
        fromUserId: String,
        toUserId: String,
        amount: Double,
        title: String
    ) -> AnyPublisher<Bool, Error> {
        
        client.request(fileName: "mock_data")
            .tryMap { (response: AllUserTransactionApiResponse) in
                var response = response

                guard let index = response.users.firstIndex(where: { $0.id == fromUserId }) else {
                    throw CustomError.error(message: "User not found", code: 404)
                }
                
                var user = cachedTransactions ?? response.users[index]
                
                // Check balance
                guard user.balance >= amount else {
                    throw CustomError.error(message: "Insufficient balance", code: 400)
                }
                
                // Deduct balance
                user.balance -= amount
                
                // new transaction
                let transaction = TransactionModel(
                    id: "TH-Bank-User" + UUID().uuidString,
                    date: Date(),
                    title: title,
                    amount: -amount
                )
                
                // Updating user
                user.transactions.append(transaction)
                response.users[index] = user
                
                // Cache locally
                cachedTransactions = user
                
                return true
            }
            .eraseToAnyPublisher()
    }
    
}
