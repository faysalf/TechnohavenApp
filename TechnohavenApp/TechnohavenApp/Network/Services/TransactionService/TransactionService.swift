//
//  TransactionService.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

class TransactionService: TransactionServiceProtocol {
    let client = NetworkClient()
    
    func transaction(userId: String) -> AnyPublisher<[TransactionModel], Error> {
        
        return client.request(fileName: "mock_data")
            .tryMap { (response: AllUserTransactionApiResponse) in
                let user = response.users.first { user in
                    user.id == userId
                }
                
                return user?.transactions ?? []
            }
            .eraseToAnyPublisher()
        
    }
    
    
}
