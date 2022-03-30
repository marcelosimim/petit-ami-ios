//
//  UserModelBuilder.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class UserModelBuilder {
    
    private var userModel = UserModel()
    
    public init() {}
    
    func withName(name:String?) -> UserModelBuilder {
        userModel.name = name
        return self
    }
    
    func withUnit(unit: Int?) -> UserModelBuilder {
        userModel.unit = unit
        return self
    }
    
    func withExercise(exercise:Int?) -> UserModelBuilder {
        userModel.exercise = exercise
        return self
    }
    
    func withFrenchLevel(frenchLevel:Double?) -> UserModelBuilder {
        userModel.frenchLevel = frenchLevel
        return self
    }
    
    func withPhoto(photo: Data?) -> UserModelBuilder {
        userModel.photo = photo
        return self
    }
    
    func build() -> UserModel {
        userModel
    }
}
