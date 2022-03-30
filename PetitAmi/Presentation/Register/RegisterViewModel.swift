//
//  RegisterViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 01/03/22.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    
    let registerUseCase: RegisterUseCase
    var onRegisterCompleted : (Error?) -> () = { error in }
    
    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }
    
    func register(name:String, email:String, password: String) {
        registerUseCase.register(name: name, email: email, password: password) { error in
            guard let _ = error else {
                self.onRegisterCompleted(error)
                return
            }
        }
    }
}
