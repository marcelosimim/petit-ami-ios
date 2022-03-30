//
//  UnitModelBuilder.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 29/03/22.
//

import Foundation

final class UnitModelBuilder {
    
    private var unitModel = UnitModel()
    
    public init() {}
    
    func withNumber(number: Int?) -> UnitModelBuilder {
        unitModel.number = number
        return self
    }
    
    func withImage(image: Data?) -> UnitModelBuilder {
        unitModel.image = image
        return self
    }
    
    func withSize(size: Int?) -> UnitModelBuilder {
        unitModel.size = size
        return self
    }
    
    func build() -> UnitModel {
        unitModel
    }
}
