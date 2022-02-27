//
//  HomeModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation

struct HomeModel {
    let userProgress: Float?
    let currentUnit: Int?
    
    init(userProgress:Float, currentUnit:Int){
        self.userProgress = userProgress
        self.currentUnit = currentUnit
    }
}
