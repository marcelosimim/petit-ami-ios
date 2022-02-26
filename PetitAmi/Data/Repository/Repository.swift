//
//  Repository.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import Foundation

protocol RepositoryProtocol {
    func getCoverImage(for unit:Int, completion: @escaping (UIImage?, Error?) -> Void)
}

class Repository: RepositoryProtocol {
    
    let firebase: FirebaseProtocol
    
    init(firebase: FirebaseProtocol){
        self.firebase = firebase
    }
    
    func getCoverImage(for unit: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        firebase.getCoverImage(for: unit, completion: completion)
    }
}
