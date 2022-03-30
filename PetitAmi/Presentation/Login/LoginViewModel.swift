//
//  LoginViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    let loginUseCase: LoginUseCase
    var loginSuccedd : (() -> ()) = {}
    var loginWithError : ((Error?) -> ()) = { error in }
    
    init(loginUseCase: LoginUseCase){
        self.loginUseCase = loginUseCase
    }
    
    func login(with email:String, and password: String){
        loginUseCase.execute(email: email, password: password) { error in
            guard let error = error else {
                self.loginSuccedd()
                return
            }
            self.loginWithError(error)
        }
    }
    
    func signOut(){
        
    }
}
