//
//  ListenAndAnswerViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 28/02/22.
//

import Foundation

class ListenAndAnswerViewModel {
    
    let repository: RepositoryProtocol!
    var exerciseModel: ExerciseModel?
    
    var onDataResults: ((ExerciseModel?) -> ()) = { data in }
    var onNextExerciseResult: (() -> ()) = { }
    
    init(repository: RepositoryProtocol){
        self.repository = repository
        self.exerciseModel = nil
    }
    
    func getData() {
        repository.getUnitAndExercise { data, error in
            guard let data = data else {
                print(error)
                return
            }
            let unit = data[0]
            let exercise = data[1]
            
            self.exerciseModel = ExerciseModel()
            self.exerciseModel?.unit.unitNumber = unit
            self.exerciseModel?.exerciseNumber = exercise
            self.getUnitSize(unit: unit)
            self.getExerciseSound(unit: unit, exercise: exercise)
            self.loadExerciseImage(unit: unit, exercise: exercise)
        }
    }
    
    func getUnitSize(unit: Int){
        repository.getUnitInfo(unit: unit) { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.exerciseModel?.unit.unitSize = data
            
            guard let exercise = self.exerciseModel?.exerciseNumber else {
                return
            }
            
            self.getNextExercise()
        }
    }
    
    func loadExerciseImage(unit:Int, exercise: Int){
        repository.getExerciseImage(unit: unit, exercise: exercise) { data, error in
            guard let data = data else {
                print(error)
                return
            }

            self.exerciseModel?.image = data
            self.onDataResults(self.exerciseModel)
        }
    }
    
    func getExerciseSound(unit:Int, exercise: Int){
        repository.getExerciseSound(unit: unit, exercise: exercise) { url, error in
            guard let url = url else {
                return
            }
            self.exerciseModel?.soundURL = url
        }
    }
    
    func getNextExercise(){
        self.exerciseModel?.nextExercise = ExerciseModel()
        
        if (exerciseModel?.exerciseNumber)! + 1 <= (exerciseModel?.unit.unitSize)!  {
            exerciseModel?.nextExercise?.unit.unitNumber = exerciseModel!.unit.unitNumber
            exerciseModel?.nextExercise?.exerciseNumber = exerciseModel!.exerciseNumber!+1
        }else{
            exerciseModel?.nextExercise?.unit.unitNumber = exerciseModel!.unit.unitNumber!+1
            exerciseModel?.nextExercise?.exerciseNumber = 1
        }
        
        repository.getExerciseAnswer(unit: (exerciseModel?.nextExercise?.unit.unitNumber)!, exercise: (exerciseModel?.nextExercise?.exerciseNumber)!) { answer, type, error in
            guard let answer = answer, let type = type else {
                return
            }
            
            self.exerciseModel?.nextExercise?.type = type
            self.exerciseModel?.answer = answer
        }
    }
    
    func goToNextExercise(){
        repository.setExercise(number: (exerciseModel?.nextExercise?.exerciseNumber)!) { error in
            guard let error = error else {
                self.onNextExerciseResult()
                return
            }

            print("error")
        }
    }
}
