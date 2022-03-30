//
//  ListenAndAnswerViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 28/02/22.
//

import Foundation

class ListenAndAnswerViewModel {
    
    let userUseCase: UserUseCase
    let unitUseCase: FetchUnitUseCase
    let exerciseUseCase: FetchExerciseUseCase
    var exercise: Exercise?
    
    var onDataResults: ((Exercise?) -> ()) = { data in }
    var onNextExerciseResult: (() -> ()) = { }
    
    init(userUseCase: UserUseCase, unitUseCase: FetchUnitUseCase, exerciseUseCase: FetchExerciseUseCase){
        self.userUseCase = userUseCase
        self.unitUseCase = unitUseCase
        self.exerciseUseCase = exerciseUseCase
    }
    
    func getData() {
        userUseCase.getInfo { result in
            switch result {
            case.success(let user):
                guard let unit = user?.unit, let exercise = user?.exercise else {
                    return
                }
                self.exercise = Exercise()
                self.exercise?.unit = Unit()
                self.exercise?.unit?.number = unit
                self.exercise?.number = exercise
                self.getUnitSize(unit: unit)
                self.getExerciseSound(unit: unit, exercise: exercise)
                self.loadExerciseImage(unit: unit, exercise: exercise)
            case .failure(_):
                return
            }
        }
    }
    
    func getUnitSize(unit: Int){
        unitUseCase.fetchSize(unit: unit) { result in
            switch result {
            case.success(let size):
                self.exercise?.unit?.size = size
                self.getNextExercise()
            case .failure(_):
                return
            }
        }
    }
    
    func loadExerciseImage(unit:Int, exercise: Int){
        exerciseUseCase.fetchImage(unit: unit, exercise: exercise) { result in
            switch result {
            case.success(let data):
                self.exercise?.image = data
                self.onDataResults(self.exercise)
            case .failure(_):
                return
            }
        }
    }
    
    func getExerciseSound(unit:Int, exercise: Int){
        exerciseUseCase.fetchSound(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let url):
                self.exercise?.soundURL = url
            case .failure(_):
                return
            }
        }
    }
    
    func getNextExercise(){
        self.exercise?.nextExercise = NextExercise()
        
        guard let unit = exercise?.unit?.number, let exercise = exercise?.number else {
            return
        }
        
        exerciseUseCase.fetchNextExercise(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let next):
                self.exercise?.nextExercise?.number = next.number
            case .failure(let error):
                return
            }
        }
    }
    
    func goToNextExercise(){
        guard let number = exercise?.nextExercise?.number else {
                return
        }
        userUseCase.setUserExercise(number: number) { error in
            guard let _ = error else {
            self.onNextExerciseResult()
            return
        }

        print("error")
        }
    }
}
