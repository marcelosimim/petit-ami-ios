//
//  RegisterViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 01/03/22.
//

import Foundation
import FirebaseAuth

class RegisterViewModel {
    
    let repositoty: RepositoryProtocol
    var onRegisterCompleted : (Error?) -> () = { error in }
    
    init(repository: RepositoryProtocol) {
        self.repositoty = repository
    }
    
    func register(name:String, email:String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                self.onRegisterCompleted(error)
                return
            }
            self.addNewUser(name: name)
        }
    }
    
    func addNewUser(name:String) {
        let user = UserModel(name: name, unit: 1, exercise: 1)
        repositoty.addNewUser(user: user, completion: { error in
            guard let error = error else {
                self.onRegisterCompleted(nil)
                return
            }
            self.onRegisterCompleted(error)
        })
    }
}
