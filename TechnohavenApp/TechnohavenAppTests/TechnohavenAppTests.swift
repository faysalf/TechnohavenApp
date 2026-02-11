//
//  TechnohavenAppTests.swift
//  TechnohavenAppTests
//
//  Created by Faysal Ahmed on 10/2/26.
//

import XCTest
@testable import TechnohavenApp
import Combine

final class TechnohavenAppTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testFetchingTransaction() {
        let expectation = expectation(description: "Fetch transactions")
        let vm = TransactionViewModel(service: TransactionService())

        vm.$transactions
            .dropFirst()
            .sink { trans in
                debugPrint("######## Test transaction list api first transaction title:- \(trans.first?.title ?? "N/A"), and total \(trans.count)")
                XCTAssertFalse(trans.isEmpty, "transaction array should not be empty")
                XCTAssertNotNil(trans.first?.title)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        vm.fetchTransaction(with: "TH-Bank-User-1111")

        wait(for: [expectation], timeout: 5)
    }


}
