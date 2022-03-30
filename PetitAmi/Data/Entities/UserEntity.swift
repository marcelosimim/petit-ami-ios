//
//  UserEntity.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

struct UserEntity {
    var name:String?
    var unit:Int?
    var exercise:Int?
    var frenchLevel:Double?
    var photo: Data?
    
    func toModel() -> UserModel {
        UserModelBuilder()
            .withName(name: name)
            .withUnit(unit: unit)
            .withExercise(exercise: exercise)
            .withFrenchLevel(frenchLevel: frenchLevel)
            .withPhoto(photo: photo)
            .build()
    }
}
