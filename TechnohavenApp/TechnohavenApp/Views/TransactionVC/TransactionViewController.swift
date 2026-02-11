//
//  TransactionViewController.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit
import Combine

class TransactionViewController: UIViewController {
    static func instance() -> TransactionViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TransactionViewControllerID") as! TransactionViewController
    }
    
    @IBOutlet weak var transactionTableView: UITableView!
    var vm = TransactionViewModel(service: TransactionService())
    private var kcm = KeychainManager.shared
    private var udm = UserDefaults.standard
    private var cancellables: Set<AnyCancellable> = []
    
    // Life cycles
    override
    func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
        configure()
    }
    
    override
    func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetch()
    }
    
    // setup
    private func setupUIs() {
        let nib = UINib(nibName: "TransactionTvCell", bundle: nil)
        transactionTableView.register(nib, forCellReuseIdentifier: TransactionTvCell.IDENTIFIER)
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
    }
    
    private func configure() {
        vm.$transactions
            .sink {[weak self] _ in
                self?.reloadUIs()
            }
            .store(in: &cancellables)
        
        vm.$errorMessage
            .sink {[weak self] message in
                if let message, !message.isEmpty {
                    self?.showBottomPopup(withMessage: message)
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetch() {
        if let userId = kcm.getUserId() {
            vm.fetchTransaction(with: userId)
        }else {
            vm.logout()
            sceneDelegate?.setRootViewController()
        }
    }
    
    private func reloadUIs() {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
        }
    }
    
}

// MARK: - UI table view delegata & datasource
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        vm.transactions.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard indexPath.row < vm.transactions.count else { return UITableViewCell() }
        
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: TransactionTvCell.IDENTIFIER, for: indexPath) as! TransactionTvCell
        cell.configure(with: vm.transactions[indexPath.row])
        
        let vw = UIView()
        vw.backgroundColor = .clear
        cell.selectedBackgroundView = vw
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }
    
    
}
