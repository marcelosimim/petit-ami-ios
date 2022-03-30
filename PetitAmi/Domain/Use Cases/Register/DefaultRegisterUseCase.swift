//
//  DefaultRegisterUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class DefaultRegisterUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository){
        self.firebaseRepository = firebaseRepository
    }
}

extension DefaultRegisterUseCase: RegisterUseCase {
    func register(name: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseRepository.register(name: name, email: email, password: password, completion: completion
        )
    }
}
