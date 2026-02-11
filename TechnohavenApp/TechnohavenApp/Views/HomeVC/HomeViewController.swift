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
    
    var vm = HomeViewModel()
    
    @IBAction
    private func logoutAction(_ sender: UIButton) {
        vm.logout()
        sceneDelegate?.setRootViewController()
    }
    
    
    
}
