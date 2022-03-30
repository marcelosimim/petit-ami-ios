//
//  HomeViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation
import FirebaseAuth

class HomeViewModel {
    
    let userUseCase: UserUseCase
    let unitUseCase: FetchUnitUseCase
    let exerciseUseCase: FetchExerciseUseCase
    
    var exercise: Exercise?
    var user: User?
    
    var signOutCompletion : ((Error?) -> ()) = { error in }
    var userInfoCompletion: (() -> ()) = { }
    var loadCoverCompletion: ((Data?) -> ()) = { data in }
    var carouselImages:[UIImage]?
    var onResults: (() -> ()) = { }
    var onFetchCarousel: (() -> ()) = { }
    var uploadFinished: (() -> ()) = { }
    
    init(userUseCase: UserUseCase, unitUseCase:FetchUnitUseCase, exerciseUseCase: FetchExerciseUseCase){
        self.userUseCase = userUseCase
        self.unitUseCase = unitUseCase
        self.exerciseUseCase = exerciseUseCase
    }
}

extension HomeViewModel {
    func signOutButtonTapped() {
        do{
            try Auth.auth().signOut()
            signOutCompletion(nil)
        }catch let error {
            signOutCompletion(error)
        }
    }
    
    func getUserInfo(){
        userUseCase.getInfo { result in
            switch result {
            case .success(let user):
                self.user = User()
                self.user?.name = user?.name
                self.user?.unit = user?.unit
                self.user?.exercise = user?.exercise
                self.getUserPhoto()
            case .failure(let error):
                return
            }
        }
    }
    
    func getUserPhoto() {
        userUseCase.downloadUserPhoto { result in
            switch result {
            case .success(let data):
                self.user?.photo = data
                self.userInfoCompletion()
            case .failure(let error):
                print("error", error)
                return
            }
        }
    }
    
    func loadCover(unit:Int) {
        unitUseCase.fetchCover(unit: unit) { result in
            switch result {
            case .success(let data):
                self.loadCoverCompletion(data)
            case .failure(_):
                self.loadCoverCompletion(nil)
            }
        }
    }

    func getExercise() {
        guard let unit = user?.unit, let exercise = user?.exercise else {
            return
        }
        
        exerciseUseCase.fetchExerciseType(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let type):
                self.exercise = Exercise()
                self.exercise?.type = type
                self.onResults()
            case .failure(_):
                return
            }
        }
    }

    func fetchCarousel(unit:Int){
//        var images:[UIImage] = []
//
//        repository.getImageCarousel(finalUnit: unit) { images, error in
//            guard let images = images else {
//                return
//            }
//
//            self.carouselImages = images
//            self.onFetchCarousel()
//        }
    }

    func frenchLevel()->String{
        guard let unit = user?.unit else {
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
    
    func uploadPhoto(image:Data) {
        userUseCase.uploadUserPhoto(image: image) { error in
            guard let error = error else {
                self.uploadFinished()
                return
            }
        }
    }
}
