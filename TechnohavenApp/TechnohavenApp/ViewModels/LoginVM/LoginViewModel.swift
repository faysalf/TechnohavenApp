//
//  LoginViewModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

class LoginViewModel {
    var service: AuthenticationServiceProtocol
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var loginSuccess: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init(service: AuthenticationServiceProtocol) {
        self.service = service
    }
    
    func login(email: String, password: String) {
        defer { isLoading = false }

        guard isValidEmail(email) else {
            errorMessage = AuthErrorEnum.invalidEmail.description
            return
        }
        guard password.count >= 6 else {
            errorMessage = AuthErrorEnum.passwordShortage.description
            return
        }

        isLoading = true
        service.login(email: email, password: password)
            .sink {[weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = extractErrorMessage(error).message
                }
                
            } receiveValue: {[weak self] user in
                self?.saveUserInfo(user: user)
                self?.loginSuccess = true
            }
            .store(in: &cancellables)
          
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex =
        #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        
        return NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
            .evaluate(with: email)
    }
    
    private func saveUserInfo(user: UserInfo) {
        UserDefaults.userName = user.fullName
        KeychainManager.shared.saveUserId(user.id)
        KeychainManager.shared.saveUserAmount(user.balance)
    }
    
}
