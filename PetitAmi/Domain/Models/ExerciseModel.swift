//
//  Exercise.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

import Foundation

struct ExerciseModel {
    var unit:UnitModel?
    var number:Int?
    var type:Bool?
    var answer:String?
    var image:Data?
    var soundURL:String?
    var nextExercise: NextExerciseModel?
}

struct NextExerciseModel {
    var type:Bool?
    var unit:Int?
    var number: Int?
}
