//
//  DefaultLoginUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class DefaultLoginUseCase {
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository){
        self.firebaseRepository = firebaseRepository
    }
}

extension DefaultLoginUseCase: LoginUseCase {
    func execute(email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseRepository.login(email: email, password: password, completion: completion)
    }
}
