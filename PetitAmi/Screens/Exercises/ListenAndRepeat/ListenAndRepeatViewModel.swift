//
//  ListenAndRepeatViewModel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 27/02/22.
//

import Foundation

class ListenAndRepeatViewModel {
    
    let repository: RepositoryProtocol!
    var exerciseModel: ExerciseModel?
    
    var onDataResults: ((ExerciseModel?) -> ()) = { data in }
    
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
            self.getExerciseAnswer(unit: unit, exercise: exercise)
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
//            if exercise + 1 <= data  {
//                self.exerciseModel?.nextExercise.unit.unitNumber = self.exerciseModel!.unit.unitNumber
//                self.exerciseModel?.nextExercise.exerciseNumber = self.exerciseModel!.exerciseNumber!+1
//            }else{
//                self.exerciseModel?.nextExercise.unit.unitNumber = self.exerciseModel!.unit.unitNumber!+1
//                self.exerciseModel?.nextExercise.exerciseNumber = 1
//            }
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
    
    func getExerciseAnswer(unit:Int, exercise: Int){
        repository.getExerciseAnswer(unit: unit, exercise: exercise) { answer, type, error in
            guard let answer = answer, let type = type else {
                return
            }
            
            self.exerciseModel?.answer = answer
            self.exerciseModel?.type = type
        }
    }
}
