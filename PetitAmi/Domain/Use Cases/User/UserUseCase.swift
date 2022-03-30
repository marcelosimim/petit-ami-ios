//
//  UserUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

protocol UserUseCase {
    func getInfo(completion: @escaping((Result<UserModel?, Error>) -> Void))
    func setUserExercise(number:Int, completion: @escaping (Error?) -> Void)
    func downloadUserPhoto(completion: @escaping((Result<Data?, Error>) -> Void))
    func uploadUserPhoto(image: Data, completion: @escaping((Error?) -> Void))
}
