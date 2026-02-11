//
//  TransactionViewModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

class TransactionViewModel {
    var service: TransactionServiceProtocol

    @Published var transactions: [TransactionModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init(service: TransactionServiceProtocol) {
        self.service = service
    }
    
    func fetchTransaction(with userId: String) {
        defer { isLoading = false }
        
        isLoading = true
        service.transaction(userId: userId)
            .sink {[weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = extractErrorMessage(error).message
                }
                
            } receiveValue: {[weak self] transactions in
                self?.transactions = transactions
            }
            .store(in: &cancellables)

    }
    
    func logout() {
        UserDefaults.isLoggedin = false
        UserDefaults.userName = ""
        KeychainManager.shared.deleteUserId()
        KeychainManager.shared.deleteUserAmount()
    }
    
}
