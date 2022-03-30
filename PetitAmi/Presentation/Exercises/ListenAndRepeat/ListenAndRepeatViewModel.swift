//
//  ListenAndRepeatViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation

class ListenAndRepeatViewModel {
    
    let userUseCase: UserUseCase
    let unitUseCase: FetchUnitUseCase
    let exerciseUseCase: FetchExerciseUseCase
    var exercise: ExerciseModel?
    
    var onDataResults: ((ExerciseModel?) -> ()) = { data in }
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
                self.exercise = ExerciseModel()
                self.exercise?.unit = UnitModel()
                self.exercise?.unit?.number = unit
                self.exercise?.number = exercise
                self.getUnitSize(unit: unit)
                self.getExerciseSound(unit: unit, exercise: exercise)
                self.getExerciseAnswer(unit: unit, exercise: exercise)
                self.loadExerciseImage(unit: unit, exercise: exercise)
            case .failure(let error):
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
            case .failure(let error):
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
            case .failure(let error):
                return
            }
        }
    }
    
    func getExerciseSound(unit:Int, exercise: Int){
        exerciseUseCase.fetchSound(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let url):
                self.exercise?.soundURL = url
            case .failure(let error):
                return
            }
        }
    }
    
    func getExerciseAnswer(unit:Int, exercise: Int){
        exerciseUseCase.fetchAnswer(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let answer):
                self.exercise?.answer = answer
            case .failure(let error):
                return
            }
        }
    }
    
    func getNextExercise(){
        self.exercise?.nextExercise = NextExerciseModel()
        
        guard let unit = exercise?.unit?.number, let exercise = exercise?.number else {
            return
        }
        
        exerciseUseCase.fetchNextExercise(unit: unit, exercise: exercise) { result in
            switch result {
            case .success(let next):
                self.exercise?.nextExercise = next
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
            guard let error = error else {
            self.onNextExerciseResult()
            return
        }

        print("error")
        }
    }
}
