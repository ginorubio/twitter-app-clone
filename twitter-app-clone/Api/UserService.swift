//
//  UserService.swift
//  twitter-app-clone
//
//  Created by user on 29/04/24.
//

import Foundation
import Firebase

struct UserService{
    
    static let shared = UserService()
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            guard let username = dictionary["username"] as? String else { return }
            print("DEBUG: Username is \(username)")
        }
    }
}
