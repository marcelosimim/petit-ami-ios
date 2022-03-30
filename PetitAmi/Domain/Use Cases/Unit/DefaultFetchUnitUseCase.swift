//
//  DefaultFetchUnitUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class DefaultFetchUnitUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository){
        self.firebaseRepository = firebaseRepository
    }
}

extension DefaultFetchUnitUseCase: FetchUnitUseCase {
    func fetchSize(unit: Int, completion: @escaping (Result<Int?, Error>) -> Void) {
        firebaseRepository.fetchUnitSize(unit: unit, completion: completion)
    }
    
    func fetchCover(unit: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        firebaseRepository.fetchUnitCover(unit: unit, completion: completion)
    }
}
