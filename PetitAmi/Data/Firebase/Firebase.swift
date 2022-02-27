//
//  Firebase.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

protocol FirebaseProtocol {
    func getCoverImage(for unit:Int, completion: @escaping (UIImage?, Error?) -> Void)
    func getUserProgress(completion: @escaping (Float?, Error?) -> Void)
    func getUnitAndExercise(completion: @escaping ([Int]?, Error?) -> Void)
    func getExerciseImage(unit u:Int, exercise e:Int, completion: @escaping (UIImage?, Error?) -> Void)
}

class Firebase: FirebaseProtocol{
    
    let userRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "")
    
    func getCoverImage(for unit:Int, completion: @escaping (UIImage?, Error?) -> Void) {
        let reference = Storage.storage().reference(withPath: "cover/capa\(unit).png")
        
        reference.getData(maxSize: 4 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(UIImage(data: data), nil)
        }
    }
    
    func getUserProgress(completion: @escaping (Float?, Error?) -> Void) {
        userRef.getDocument { document, error in
            guard let document = document else {
                completion(nil, error)
                return
            }
            
            let unit = document.data()!["unit"] as! Float
            let progress = unit/96.0
            completion(progress, error)
        }
    }
    
    func getUnitAndExercise(completion: @escaping ([Int]?, Error?) -> Void) {
        userRef.getDocument { document, error in
            guard let document = document else {
                completion([], error)
                return
            }
            
            let unit = document.data()!["unit"] as! Int
            let exercise = document.data()!["exercise"] as! Int
            completion([unit, exercise], error)
        }
    }
    
    func getExerciseImage(unit u:Int, exercise e:Int, completion: @escaping (UIImage?, Error?) -> Void) {
        let reference = Storage.storage().reference(withPath: "exercises/unit\(u)/images/\(e).png")
        
        reference.getData(maxSize: 4 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(UIImage(data: data), nil)
        }
    }
}
