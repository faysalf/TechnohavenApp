//
//  SendMoneyViewModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

class SendMoneyViewModel {
    let service: SendMoneyServiceProtocol
    @Published var isLoading: Bool = false
    @Published var transactionSuccesful: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private var kcm = KeychainManager.shared

    init(service: SendMoneyServiceProtocol) {
        self.service = service
    }
    
    func sendMoney(to id: String, fromUser: String, amount: Double) {
        service.sendMoney(
            fromUserId: fromUser,
            toUserId: id,
            amount: amount,
            title: "Send Money - Debitted"
        )
        .sink {[weak self] completion in
            if case let .failure(error) = completion {
                self?.errorMessage = extractErrorMessage(error).message
            }
            
        } receiveValue: {[weak self] isSuccesful in
            guard let self else { return }
            transactionSuccesful = isSuccesful
            kcm.saveUserAmount((kcm.getUserAmount() ?? 0.0) - amount)
        }
        .store(in: &cancellables)


    }
    
}
