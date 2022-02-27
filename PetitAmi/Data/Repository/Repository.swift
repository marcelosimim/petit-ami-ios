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
    func getUserProgress(completion: @escaping (Float?, Error?) -> Void)
    func getUnitAndExercise(completion: @escaping ([Int]?, Error?) -> Void)
    func getExerciseImage(unit u:Int, exercise e:Int, completion: @escaping (UIImage?, Error?) -> Void)
    func getExerciseSound(unit u:Int, exercise e:Int, completion: @escaping (String?, Error?) -> Void)
    func getExerciseAnswer(unit u:Int, exercise e:Int, completion: @escaping (String?, Bool?, Error?) -> Void)
    func getUnitInfo(unit u:Int, completion: @escaping (Int?, Error?) -> Void)
}

class Repository: RepositoryProtocol {
    
    let firebase: FirebaseProtocol
    
    init(firebase: FirebaseProtocol){
        self.firebase = firebase
    }
    
    func getCoverImage(for unit: Int, completion: @escaping (UIImage?, Error?) -> Void) {
        firebase.getCoverImage(for: unit, completion: completion)
    }
    
    func getUserProgress(completion: @escaping (Float?, Error?) -> Void){
        firebase.getUserProgress(completion: completion)
    }
    
    func getUnitAndExercise(completion: @escaping ([Int]?, Error?) -> Void){
        firebase.getUnitAndExercise(completion: completion)
    }
    
    func getExerciseImage(unit u:Int, exercise e:Int, completion: @escaping (UIImage?, Error?) -> Void){
        firebase.getExerciseImage(unit: u, exercise: e, completion: completion)
    }
    
    func getExerciseSound(unit u: Int, exercise e: Int, completion: @escaping (String?, Error?) -> Void) {
        firebase.getExerciseSound(unit: u, exercise: e, completion: completion)
    }
    
    func getExerciseAnswer(unit u:Int, exercise e:Int, completion: @escaping (String?, Bool?, Error?) -> Void){
        firebase.getExerciseAnswer(unit: u, exercise: e, completion: completion)
    }
    
    func getUnitInfo(unit u:Int, completion: @escaping (Int?, Error?) -> Void){
        firebase.getUnitInfo(unit: u, completion: completion)
    }
}
