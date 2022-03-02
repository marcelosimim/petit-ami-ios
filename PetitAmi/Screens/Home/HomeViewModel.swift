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
    var userInfoCompletion: (() -> ()) = { }
    var loadCoverCompletion: ((UIImage?, Error?) -> ()) = { data, error in }
    var exerciseModel: ExerciseModel?
    var userModel: UserModel?
    var onResults: (() -> ()) = { }
    
    func signOutButtonTapped() {
        do{
            try Auth.auth().signOut()
            signOutCompletion(nil)
        }catch let error {
            signOutCompletion(error)
        }
    }
    
    func getUserInfo(){
        repository.getUserInfo { user, error in
            guard let user = user else {
                print(error)
                return
            }

            self.userModel = UserModel()
            self.userModel?.name = user.name
            self.userModel?.unit = user.unit
            self.userModel?.exercise = user.exercise
            self.userInfoCompletion()
        }
    }
    
    func loadCover(unit:Int) {
        repository.getCoverImage(for: unit) { data, error in
            guard let data = data else {
                self.loadCoverCompletion(nil, error)
                return
            }
            
            self.loadCoverCompletion(data, nil)
        }
    }
    
    func getExercise() {
        repository.getUnitAndExercise { result, error in
            guard let result = result else {
                print(error)
                return
            }

            let unit = result[0]
            let exercise = result[1]
            
            self.repository.getExerciseAnswer(unit: unit, exercise: exercise) { answer, type, error in
                guard let type = type else {
                    print(error)
                    return
                }
                
                self.exerciseModel = ExerciseModel()
                self.exerciseModel?.type = type
                self.onResults()
            }
            
        }
    }
    
    func fetchCarousel(currentUnit:Int){
        var images:[UIImage] = []
        
        for i in 1...currentUnit {
            print(i)
        }
    }
    
    func frenchLevel()->String{
        guard let unit = userModel?.unit else {
            return ""
        }
        
        if unit <= 36 {
            return "Básico"
        }else if unit <= 71 {
            return "Intermediário"
        }else{
            return "Avançado"
        }
    }
}
