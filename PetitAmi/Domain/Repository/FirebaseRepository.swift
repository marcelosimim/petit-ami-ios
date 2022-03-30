//
//  FirebaseRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 23/03/22.
//

import Foundation

protocol FirebaseRepository {
    func login(email:String, password: String, completion: @escaping(Error?) -> Void)
    func register(name:String, email:String, password: String, completion: @escaping(Error?) -> Void)
    func downloadUserPhoto(completion: @escaping((Result<Data?, Error>) -> Void))
    func uploadUserPhoto(image: Data, completion: @escaping((Error?) -> Void))
    func getUserInfo(completion: @escaping((Result<UserModel?, Error>) -> Void))
    func setUserExercise(number:Int, completion: @escaping (Error?) -> Void)
    func fetchExerciseType(unit:Int, exercise: Int, completion: @escaping (Result<Bool?, Error>) -> Void)
    func fetchExerciseImage(unit:Int, exercise: Int, completion: @escaping (Result<Data?, Error>) -> Void)
    func fetchExerciseSound(unit:Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func fetchExerciseAnswer(unit:Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void)
    func fetchNextExercise(unit:Int, exercise: Int, completion: @escaping (Result<NextExerciseModel, Error>) -> Void)
    func fetchUnitSize(unit:Int, completion: @escaping(Result<Int?, Error>) -> Void)
    func fetchUnitCover(unit: Int, completion: @escaping(Result<Data?, Error>) -> Void)
}
