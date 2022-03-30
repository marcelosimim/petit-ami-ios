//
//  DefaultUserUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class DefaultUserUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository){
        self.firebaseRepository = firebaseRepository
    }
}

extension DefaultUserUseCase: UserUseCase {
    
    func getInfo(completion: @escaping ((Result<UserModel?, Error>) -> Void)) {
        firebaseRepository.getUserInfo(completion: completion)
    }
    
    func setUserExercise(number: Int, completion: @escaping (Error?) -> Void) {
        firebaseRepository.setUserExercise(number: number, completion: completion)
    }
    
    func downloadUserPhoto(completion: @escaping ((Result<Data?, Error>) -> Void)) {
        firebaseRepository.downloadUserPhoto(completion: completion)
    }
    
    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void)) {
        firebaseRepository.uploadUserPhoto(image: image, completion: completion)
    }
}
