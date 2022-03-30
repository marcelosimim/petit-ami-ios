//
//  EntityExercise.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

struct ExerciseEntity {
    var unit:UnitEntity
    var number:Int
    var type:Bool
    var answer:String
    var image:Data
    var soundURL:String
    var nextExercise: NextExerciseEntity
    
    func toModel() -> ExerciseModel {
        ExerciseModelBuilder()
            .withUnit(unit: unit.toModel())
            .withNumber(number: number)
            .withType(type: type)
            .withAnswer(answer: answer)
            .withImage(image: image)
            .withSoundURL(soundURL: soundURL)
            .withNextExercise(nextExercise: nextExercise.toModel())
            .build()
    }
}

struct NextExerciseEntity {
    var type:Bool?
    var unit:Int?
    var number: Int?
    
    func toModel() -> NextExerciseModel {
        ExerciseModelBuilder()
            .withUnit(unit: UnitModelBuilder().withNumber(number: unit).build())
            .withNumber(number: number)
            .withType(type: type)
            .buildNextExercise()
    }
}
