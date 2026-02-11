//
//  Ext+UserDefaults.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let login = "isLogin"
        static let lodgin = "isLogin"
    }
    
    static var isLoggedin: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.login) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.login) }
    }
    
    
}
