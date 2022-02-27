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
}

class Firebase: FirebaseProtocol{

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
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(Auth.auth().currentUser?.uid ?? "")
        
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
}
