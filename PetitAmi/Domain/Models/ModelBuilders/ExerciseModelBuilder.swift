//
//  ExerciseModelBuilder.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class ExerciseModelBuilder {
    
    private var exerciseModel = ExerciseModel()
    private var nextExerciseModel = NextExerciseModel()
    
    public init() {}
    
    func withUnit(unit:UnitModel?) -> ExerciseModelBuilder {
        exerciseModel.unit = unit
        return self
    }
    
    func withNumber(number: Int?) -> ExerciseModelBuilder {
        exerciseModel.number = number
        return self
    }
    
    func withType(type: Bool?) -> ExerciseModelBuilder {
        exerciseModel.type = type
        return self
    }
    
    func withAnswer(answer:String?) -> ExerciseModelBuilder {
        exerciseModel.answer = answer
        return self
    }
    
    func withImage(image: Data?) -> ExerciseModelBuilder {
        exerciseModel.image = image
        return self
    }
    
    func withSoundURL(soundURL:String?) -> ExerciseModelBuilder {
        exerciseModel.soundURL = soundURL
        return self
    }
    
    func withNextExercise(nextExercise: NextExerciseModel?) -> ExerciseModelBuilder {
        exerciseModel.nextExercise = nextExercise
        return self
    }
    
    func build() -> ExerciseModel {
        exerciseModel
    }
    
    func buildNextExercise() -> NextExerciseModel {
        nextExerciseModel
    }
}
