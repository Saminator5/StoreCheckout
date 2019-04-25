//
//  User.swift
//  QRCodeReader
//
//  Created by Sagar Unagar on 22/04/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation

let UserEmail = "email"
let UserId = "id"

class User {
    var id: String?
    var email: String?
    
    var isLoggedIn: Bool {
        return self.id != nil
    }
    
    static let currentUser: User = {
        let instance = User()
        return instance
    }()
    
    init() {
        self.setUp()
    }
    
    func setUp () {
        self.id = UserDefaults.standard.string(forKey: UserId)
        self.email = UserDefaults.standard.string(forKey: UserEmail)
    }
    
    func saveUserInformation (userInfo: [String: Any]) {
        if let id = userInfo[UserId] as? String {
            self.id = id
            UserDefaults.standard.set(id, forKey: UserId)
        }
        
        if let email = userInfo[UserEmail] as? String {
            self.email = email
            UserDefaults.standard.set(email, forKey: UserEmail)
        }
    }
    
    func logOut() {
        self.id = nil
        self.email = nil
        
        UserDefaults.standard.set(nil, forKey: UserId)
        UserDefaults.standard.set(nil, forKey: UserEmail)
    }
}
