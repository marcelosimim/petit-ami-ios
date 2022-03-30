//
//  Exercise.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 30/03/22.
//

import Foundation

struct Exercise {
    var unit:Unit?
    var number:Int?
    var type:Bool?
    var answer:String?
    var image:Data?
    var soundURL:String?
    var nextExercise: NextExercise?
}

struct NextExercise {
    var type:Bool?
    var unit:Int?
    var number: Int?
}
