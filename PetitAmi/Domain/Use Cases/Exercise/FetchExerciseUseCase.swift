//
//  FetchExerciseUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

protocol FetchExerciseUseCase {
    func fetchImage(unit:Int, exercise: Int, completion: @escaping (Result<Data?, Error>) -> Void)
    func fetchSound(unit:Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func fetchAnswer(unit:Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func fetchNextExercise(unit:Int, exercise: Int, completion: @escaping (Result<NextExerciseModel, Error>) -> Void)
    func fetchExerciseType(unit: Int, exercise: Int, completion: @escaping (Result<Bool?, Error>) -> Void)
}
