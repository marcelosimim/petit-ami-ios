//
//  RegisterUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

protocol RegisterUseCase {
    func register(name:String, email:String, password: String, completion: @escaping(Error?) -> Void)
}
