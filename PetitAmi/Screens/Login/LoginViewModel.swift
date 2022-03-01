//
//  LoginViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    var loginSuccedd : (() -> ()) = {}
    var loginWithError : ((Error?) -> ()) = { error in }
    
    func login(with email:String, and password: String){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                self.loginWithError(error)
                return
            }
            
            self.loginSuccedd()
        }
    }
    
    func signOut(){
        
    }
    
}
