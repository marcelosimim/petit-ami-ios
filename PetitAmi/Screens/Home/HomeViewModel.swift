//
//  HomeViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation
import Firebase
import FirebaseAuth

class HomeViewModel {
    
    let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!
    var signOutCompletion : ((Error?) -> ()) = { error in }
    var userProgressCompletion: ((Float?, Error?) -> ()) = { data, error in }
    var loadCoverCompletion: ((UIImage?, Error?) -> ()) = { data, error in }
    
    func signOutButtonTapped() {
        do{
            try Auth.auth().signOut()
            signOutCompletion(nil)
        }catch let error {
            signOutCompletion(error)
        }
    }
    
    func getUserProgress(){
        repository.getUserProgress { data, error in
            guard let data = data else {
                self.userProgressCompletion(nil, error)
                return
            }
            self.userProgressCompletion(data, nil)
        }
    }
    
    func loadCover() {
        repository.getCoverImage(for: 1) { data, error in
            guard let data = data else {
                self.loadCoverCompletion(nil, error)
                return
            }
            
            self.loadCoverCompletion(data, nil)
        }
    }
}
