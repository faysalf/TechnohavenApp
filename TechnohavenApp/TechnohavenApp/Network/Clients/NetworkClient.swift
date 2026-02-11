//
//  NetworkClient.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Combine

final class NetworkClient {
    
    func request<T: Decodable>(
        fileName: String
    ) -> AnyPublisher<T, Error> {
        Future { promise in
            do {
                guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                    throw CustomError.error(message: "File not found", code: 404)
                }
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let value = try decoder.decode(T.self, from: data)
                promise(.success(value))
                
            } catch {
                promise(.failure(error))
            }
        }
        .retry(2)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
    }
    
    func fetchData() -> AnyPublisher<AllUserTransactionModel, Error> {
        Future { promise in
            do {
                guard let url = Bundle.main.url(forResource: "login_mock_data", withExtension: "json") else {
                    throw CustomError.error(message: "File not found", code: 404)
                }
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let value = try decoder.decode(AllUserTransactionModel.self, from: data)
                promise(.success(value))
                
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
        
    }
    
    
}

