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
    func getExerciseSound(unit u:Int, exercise e:Int, completion: @escaping (String?, Error?) -> Void)
    func getExerciseAnswer(unit u:Int, exercise e:Int, completion: @escaping (String?, Bool?, Error?) -> Void)
    func getUnitInfo(unit u:Int, completion: @escaping (Int?, Error?) -> Void)
    func setExercise(number:Int, completion: @escaping (Error?) -> Void)
    func addNewUser(user:UserModel, completion: @escaping (Error?) -> Void)
}

class Firebase: FirebaseProtocol{
    //MARK: - Exercises Section
    
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
    
    func getExerciseSound(unit u: Int, exercise e: Int, completion: @escaping (String?, Error?) -> Void) {
        let reference = Storage.storage().reference(withPath: "exercises/unit\(u)/audios/\(e).mp3")
        
        reference.downloadURL { url, error in
            guard let url = url else {
                completion(nil, error)
                return
            }
            
            completion(url.absoluteString,nil)
        }
    }
    
    func getExerciseAnswer(unit u: Int, exercise e: Int, completion: @escaping (String?, Bool?, Error?) -> Void) {
        let exerciseRef = Firestore.firestore().collection("unit\(u)").document("e\(e)")
        
        exerciseRef.getDocument { document, error in
            guard let document = document else {
                completion(nil, nil, error)
                return
            }
            
            let type = document.data()!["answer"] as! Bool
            let check = document.data()!["check"] as! String
            completion(check, type, error)
        }
    }
    
    func getUnitInfo(unit u: Int, completion: @escaping (Int?, Error?) -> Void) {
        let unitRef = Firestore.firestore().collection("unit\(u)").document("info")
        
        unitRef.getDocument { document, error in
            guard let document = document else {
                completion(nil, error)
                return
            }
            
            let size = document.data()!["size"] as! Int
            completion(size, error)
        }
    }
    
    func setExercise(number:Int, completion: @escaping (Error?) -> Void) {
        userRef.updateData([
            "exercise" : number
        ]){ error in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }
    
    //MARK: - User Section
    
    lazy var userRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "")
    
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
    
    func addNewUser(user:UserModel, completion: @escaping (Error?) -> Void) {
        userRef.setData([
            "name": user.name,
            "unit": user.unit,
            "exercise": user.exercise
        ]){
            error in
            guard let error = error else {
                completion(nil)
                return
            }
            completion(error)
        }
    }
}
