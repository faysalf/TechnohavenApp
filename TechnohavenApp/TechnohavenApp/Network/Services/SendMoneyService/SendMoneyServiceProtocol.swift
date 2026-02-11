//
//  SendMoneyServiceProtocol.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

protocol SendMoneyServiceProtocol {
    func sendMoney(
        fromUserId: String,
        toUserId: String,
        amount: Double,
        title: String
    ) -> AnyPublisher<Bool, Error>
    
}
