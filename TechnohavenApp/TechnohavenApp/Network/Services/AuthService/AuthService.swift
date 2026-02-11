//
//  AuthService.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

class AuthenticationService: AuthenticationServiceProtocol {
    let client = NetworkClient()
    
    func login(
        email: String,
        password: String
    ) -> AnyPublisher<UserInfo, Error> {
        
        return client.request(fileName: "login_mock_data")
            .tryMap { (response: AllUserLoginResponseModel) in
                let user = response.usersLogin.first { user in
                    user.email == email && user.password == password
                }
                guard let user else {
                    throw CustomError.error(message: "No user found!", code: 200)
                }
                return user
            }
            .eraseToAnyPublisher()
        
    }
    
    
}
