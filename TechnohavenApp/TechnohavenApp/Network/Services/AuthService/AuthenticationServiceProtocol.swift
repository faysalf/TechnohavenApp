//
//  AuthenticationServiceProtocol.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<UserInfo, Error>
}
