//
//  LoginViewController.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    static func instance() -> LoginViewController {
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
    }
    
    // MARK: - Variables
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var vm = LoginViewModel(service: AuthenticationService())
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupKeyboardDismissal()

    }
    
    // MARK: - Setup & Configuration
    private func configure() {
        vm.$errorMessage
            .sink {[weak self] errorMessage in
                if let errorMessage {
                    self?.showBottomPopup(withMessage: errorMessage)
                }
            }
            .store(in: &cancellables)
        
        vm.$loginSuccess
            .sink { [weak self] isSucces in
                if isSucces {
                    self?.showBottomPopup(isError: false, withMessage: "Login success!")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                        self?.presentHomeVC()
                    }
                }
            }
            .store(in: &cancellables)
        
    }
    
    // MARK: - Actions
    @IBAction
    private func loginAction(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            vm.errorMessage = "Please enter your email address."
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            vm.errorMessage = "Please enter your password."
            return
        }
        
        vm.login(email: email, password: password)
        
    }
    
    private func presentHomeVC() {
        
    }
    
    
}
