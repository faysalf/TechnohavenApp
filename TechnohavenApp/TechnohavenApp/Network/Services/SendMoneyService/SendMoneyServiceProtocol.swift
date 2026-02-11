//
//  SendMoneyServiceProtocol.swift
//  TechnohavenApp
//
//  Created by Ema Akter on 11/2/26.
//

import Foundation
import Combine

protocol SendMoneyServiceProtocol {
    func sendMoney(
        from userId: String,
        to user: String,
        amount: Double,
        title: String
    ) -> AnyPublisher<Bool, Error>
    
}
