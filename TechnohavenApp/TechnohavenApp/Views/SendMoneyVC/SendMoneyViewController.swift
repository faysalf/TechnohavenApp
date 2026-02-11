//
//  SendMoneyViewController.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit
import Combine

class SendMoneyViewController: UIViewController {
    static func instance() -> SendMoneyViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SendMoneyViewControllerID") as! SendMoneyViewController
    }
    @IBOutlet weak var receiverIdTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    private var kcm = KeychainManager.shared
    private var udm = UserDefaults.standard
    private var cancellables: Set<AnyCancellable> = []
    var vm = SendMoneyViewModel(service: SendMoneyService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupKeyboardDismissal()
    }
    
    private func setup() {
        vm.$errorMessage
            .sink {[weak self] errorMessage in
                if let errorMessage {
                    self?.showBottomPopup(withMessage: errorMessage)
                }
            }
            .store(in: &cancellables)
        
        vm.$transactionSuccesful
            .sink { [weak self] isSucces in
                if isSucces {
                    DispatchQueue.main.async {
                        self?.showBottomPopup(isError: false, withMessage: "Send Money is successful.")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    // Actions
    @IBAction
    func sendMoneyButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let receiverId = receiverIdTextField.text, !receiverId.isEmpty,
              let amount = amountTextField.text, !amount.isEmpty,
              let amnt = Double(amount) else {
            showBottomPopup(withMessage: "Please enter the receiver ID and amount.")
            return
        }
        
//        guard let availableAmnt = kcm.getUserAmount(),
//              (availableAmnt > 0 && amnt <= availableAmnt) else {
//            showBottomPopup(withMessage: "Sorry! You don't have sufficient balance.")
//            return
//        }
        
        vm.sendMoney(to: receiverId, fromUser: kcm.getUserId()!, amount: amnt)
        
        
    }
    
    
}
