//
//  TransactionService.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

var cachedTransactions: UserTransactionsModel?

class TransactionService: TransactionServiceProtocol {
    let client = NetworkClient()
    
    func transaction(userId: String) -> AnyPublisher<[TransactionModel], Error> {
        
        return client.request(fileName: "mock_data")
            .tryMap { (response: AllUserTransactionApiResponse) in
                let user = response.users.first { user in
                    user.id == userId
                }
                
                if let cachedTransactions {
                    return cachedTransactions.transactions
                }else {
                    cachedTransactions = user
                    return user?.transactions ?? []
                }

            }
            .eraseToAnyPublisher()
        
    }
    
    
}
