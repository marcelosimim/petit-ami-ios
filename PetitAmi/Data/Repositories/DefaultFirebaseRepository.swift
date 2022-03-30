//
//  DefaultFirebaseRepository.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 23/03/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

final class DefaultFirebaseRepository: FirebaseRepository {
    lazy var userRef = Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "")
    lazy var storage = Storage.storage()
    lazy var firestore = Firestore.firestore()
    var unitSize: Int?
}

// MARK: - Firebase Auth

extension DefaultFirebaseRepository {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(error)
        }
    }
    
    func register(name: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let _ = authDataResult else {
                completion(error)
                return
            }

            self.userRef.setData([
                "name": name,
                "unit": 1,
                "exercise": 1
            ]){
                error in
                completion(error)
            }
        }
    }
}

// MARK: - User Section

extension DefaultFirebaseRepository {
    func getUserInfo(completion: @escaping ((Result<UserModel?, Error>) -> Void)) {
            var user = UserEntity()
            
            userRef.getDocument { document, error in
                guard let document = document?.data() else {
                    completion(.failure(error!))
                    return
            }
                
            user.name = document["name"] as? String
            user.unit = document["unit"] as? Int
            user.exercise = document["exercise"] as? Int
                
            completion(.success(user.toModel()))
        }
    }
    
    func setUserExercise(number: Int, completion: @escaping (Error?) -> Void) {
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
    
    func downloadUserPhoto(completion: @escaping ((Result<Data?, Error>) -> Void)) {
        let reference = storage.reference(withPath: "users/\(Auth.auth().currentUser?.uid ?? "")/perfil.png")
        
        reference.getData(maxSize: 4 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
    
    func uploadUserPhoto(image: Data, completion: @escaping ((Error?) -> Void)) {
        let reference = storage.reference(withPath: "users/\(Auth.auth().currentUser?.uid ?? "")/perfil.png")
        
        let uploadTask = reference.putData(image, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                completion(error)
                return
              }
            completion(error)
        }
    }
}

// MARK: - Exercise Section

extension DefaultFirebaseRepository {
    
    func fetchExerciseImage(unit: Int, exercise: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        let reference = storage.reference(withPath: "exercises/unit\(unit)/images/\(exercise).png")
        
        reference.getData(maxSize: 4 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
            //completion(UIImage(data: data), nil)
        }
    }
    
    func fetchExerciseSound(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let reference = storage.reference(withPath: "exercises/unit\(unit)/audios/\(exercise).mp3")
        
        reference.downloadURL { url, error in
            guard let url = url else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(url.absoluteString))
        }
    }
    
    func fetchExerciseAnswer(unit: Int, exercise: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let reference = firestore.collection("unit\(unit)").document("e\(exercise)")
        
        reference.getDocument { document, error in
            guard let document = document else {
                completion(.failure(error!))
                return
            }
            
            let answer = document.data()!["check"] as! String
            
            completion(.success(answer))
        }
    }
    
    func fetchExerciseType(unit: Int, exercise: Int, completion: @escaping (Result<Bool?, Error>) -> Void) {
        let reference = firestore.collection("unit\(unit)").document("e\(exercise)")
        
        reference.getDocument { document, error in
            guard let document = document else {
                completion(.failure(error!))
                return
            }
            
            let type = document.data()!["answer"] as! Bool
            
            completion(.success(type))
        }
    }
    
    func fetchNextExercise(unit:Int, exercise: Int, completion: @escaping (Result<NextExerciseModel, Error>) -> Void) {
        if let size = unitSize {
            if exercise + 1 <= size {
                let reference = firestore.collection("unit\(unit)").document("e\(exercise+1)")
                reference.getDocument { document, error in
                    guard let document = document else {
                        completion(.failure(error!))
                        return
                    }
                    
                    var nextExercise = NextExerciseEntity()
                    nextExercise.number = exercise + 1
                    nextExercise.unit = unit
                    nextExercise.type = document.data()!["answer"] as? Bool
                    
                    completion(.success(nextExercise.toModel()))
                }
            }else{
                let reference = firestore.collection("unit\(unit+1)").document("e\(1)")
                reference.getDocument { document, error in
                    guard let document = document else {
                        completion(.failure(error!))
                        return
                    }
                    
                    var nextExercise = NextExerciseEntity()
                    nextExercise.number = exercise + 1
                    nextExercise.unit = unit
                    nextExercise.type = document.data()!["answer"] as? Bool
                    
                    completion(.success(nextExercise.toModel()))
                }
            }
        }
    }
}

// MARK: - Unit Section

extension DefaultFirebaseRepository {
    
    func fetchUnitSize(unit: Int, completion: @escaping (Result<Int?, Error>) -> Void) {
        let reference =  firestore.collection("unit\(unit)").document("info")
        
        reference.getDocument { document, error in
            guard let document = document else {
                completion(.failure(error!))
                return
            }
            
            self.unitSize = document.data()!["size"] as! Int
            completion(.success(self.unitSize))
        }
    }
    
    func fetchUnitCover(unit: Int, completion: @escaping (Result<Data?, Error>) -> Void) {
        let reference = storage.reference(withPath: "cover/capa\(unit).png")
        
        reference.getData(maxSize: 4 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
    }
}
