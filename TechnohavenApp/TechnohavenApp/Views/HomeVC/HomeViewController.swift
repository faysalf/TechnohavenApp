//
//  HomeViewController.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    static func instance() -> HomeViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var accountIdLabel: UILabel!
    var vm = HomeViewModel()
    var km = KeychainManager.shared
    
    // MARK: - Life Cycle
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }
    
    // setup
    private func setup() {
        userNameLabel.text = UserDefaults.userName
        currentBalanceLabel.text = "Tk \(km.getUserAmount() ?? 0.0)"
        accountIdLabel.text = "Account ID: \(km.getUserId() ?? "--")"
    }
    
    @IBAction
    private func logoutAction(_ sender: UIButton) {
        vm.logout()
        sceneDelegate?.setRootViewController()
    }
    
    @IBAction
    func sendMoneyButtonAction(_ sender: UIButton) {
        let vc = SendMoneyViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    func transactionButtonAction(_ sender: UIButton) {
        let vc = TransactionViewController.instance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
