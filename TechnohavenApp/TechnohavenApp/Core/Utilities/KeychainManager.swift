//
//  KeychainManager.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation
import Security

class KeychainManager {

    static let shared = KeychainManager()
    private init() {}

    private let service = "com.faysal.UserDirectory"

    enum Keys: String {
        case userID = "userID"
        case amount = "userAmount"
    }

    // MARK: User ID
    @discardableResult
    func saveUserId(_ id: String) -> Bool {
        guard let data = id.data(using: .utf8) else { return false }
        return save(data: data, for: .userID)
    }

    func getUserId() -> String? {
        guard let data = getData(for: .userID) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    @discardableResult
    func deleteUserId() -> Bool {
        return delete(for: .userID)
    }

    // MARK: User Amount
    @discardableResult
    func saveUserAmount(_ amount: Double) -> Bool {
        let data = withUnsafeBytes(of: amount) { Data($0) }
        return save(data: data, for: .amount)
    }

    func getUserAmount() -> Double? {
        guard let data = getData(for: .amount) else { return nil }
        return data.withUnsafeBytes { $0.load(as: Double.self) }
    }

    @discardableResult
    func deleteUserAmount() -> Bool {
        return delete(for: .amount)
    }

}

extension KeychainManager {

    private func baseQuery(for key: Keys) -> [String: Any] {
        [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrService as String : service,
            kSecAttrAccount as String : key.rawValue
        ]
    }

    private func save(data: Data, for key: Keys) -> Bool {

        var query = baseQuery(for: key)

        let attributesToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]

        let status = SecItemCopyMatching(query as CFDictionary, nil)

        if status == errSecSuccess {
            return SecItemUpdate(query as CFDictionary,
                                 attributesToUpdate as CFDictionary) == errSecSuccess
        } else {
            query[kSecValueData as String] = data
            return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
        }
    }

    private func getData(for key: Keys) -> Data? {

        var query = baseQuery(for: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else { return nil }
        return result as? Data
    }

    @discardableResult
    private func delete(for key: Keys) -> Bool {
        let query = baseQuery(for: key)
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
}
