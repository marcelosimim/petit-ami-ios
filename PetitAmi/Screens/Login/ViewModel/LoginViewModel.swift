//
//  LoginViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    var onResultLogin : ((Error?) -> ()) = { error in }
    
    func login(with email:String, and password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                self.onResultLogin(error)
                return
            }
            self.onResultLogin(error)
        }
    }
}
