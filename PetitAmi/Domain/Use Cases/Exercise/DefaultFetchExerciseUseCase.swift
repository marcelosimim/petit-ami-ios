//
//  DefaultFetchExerciseUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class DefaultFetchExerciseUseCase {
    
    private let firebaseRepository: FirebaseRepository
    
    init(firebaseRepository: FirebaseRepository){
        self.firebaseRepository = firebaseRepository
    }
}

extension DefaultFetchExerciseUseCase: FetchExerciseUseCase {
    
    func fetchImage(unit: Int, exercise: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        firebaseRepository.fetchExerciseImage(unit: unit, exercise: exercise, completion: completion)
    }
    
    func fetchSound(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        firebaseRepository.fetchExerciseSound(unit: unit, exercise: exercise, completion: completion)
    }
    
    func fetchAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        firebaseRepository.fetchExerciseAnswer(unit: unit, exercise: exercise, completion: completion)
    }
    
    func fetchExerciseType(unit: Int, exercise: Int, completion: @escaping (Result<Bool?, Error>) -> Void) {
        firebaseRepository.fetchExerciseType(unit: unit, exercise: exercise, completion: completion)
    }
    
    func fetchNextExercise(unit:Int, exercise: Int, completion: @escaping (Result<NextExerciseModel, Error>) -> Void) {
        firebaseRepository.fetchNextExercise(unit: unit, exercise: exercise, completion: completion)
    }
}
