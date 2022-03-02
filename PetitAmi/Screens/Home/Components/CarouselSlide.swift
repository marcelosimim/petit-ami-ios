//
//  CarouselSlide.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 01/03/22.
//

import UIKit

public struct CarouselSlide {
    public var image : UIImage
    public var title : String?
    public var score: String?
    public var type: String?
    public var distance: String?
    
    
    public init(image: UIImage,
                title: String? = nil,
                score: String? = nil,
                type: String? = nil,
                distance: String? = nil) {
        
        self.image = image
        self.title = title
        self.score = score
        self.type = type
        self.distance = distance
    }
}

