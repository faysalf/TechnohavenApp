//
//  TransactionServiceProtocol.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

protocol TransactionServiceProtocol {
    func transaction(userId: String) -> AnyPublisher<[TransactionModel], Error>
}
