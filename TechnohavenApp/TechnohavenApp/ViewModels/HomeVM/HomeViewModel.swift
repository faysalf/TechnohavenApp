//
//  HomeViewModel.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

class HomeViewModel {
    
    
    
    
    
    
    
    
    
    
    func logout() {
        UserDefaults.isLoggedin = false
        UserDefaults.userName = ""
        KeychainManager.shared.deleteUserId()
        KeychainManager.shared.deleteUserAmount()
    }
    
}
