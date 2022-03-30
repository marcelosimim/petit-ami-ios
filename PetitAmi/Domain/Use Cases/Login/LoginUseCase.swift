//
//  LoginUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

protocol LoginUseCase {
    func execute(email:String, password: String, completion: @escaping(Error?) -> Void)
}
