//
//  EntityUnit.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

struct UnitEntity {
    var number: Int
    var size: Int
    var image: Data
    
    func toModel() -> UnitModel {
        UnitModelBuilder()
            .withNumber(number: number)
            .withSize(size: size)
            .withImage(image: image)
            .build()
    }
}
