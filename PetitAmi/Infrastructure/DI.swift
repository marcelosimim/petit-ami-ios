//
//  DI.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 24/03/22.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()
        
        container.register(FirebaseRepository.self) {_ in DefaultFirebaseRepository()}
        container.register(LoginUseCase.self) {r in DefaultLoginUseCase(firebaseRepository: r.resolve(FirebaseRepository.self)!)}
        container.register(RegisterUseCase.self) {r in DefaultRegisterUseCase(firebaseRepository: r.resolve(FirebaseRepository.self)!)}
        container.register(UserUseCase.self) {r in DefaultUserUseCase(firebaseRepository: r.resolve(FirebaseRepository.self)!)}
        container.register(FetchExerciseUseCase.self) {r in DefaultFetchExerciseUseCase(firebaseRepository: r.resolve(FirebaseRepository.self)!)}
        container.register(FetchUnitUseCase.self) {r in DefaultFetchUnitUseCase(firebaseRepository: r.resolve(FirebaseRepository.self)!)}
        container.register(LoginViewModel.self) {r in LoginViewModel(loginUseCase: r.resolve(LoginUseCase.self)!)}
        container.register(HomeViewModel.self) {r in HomeViewModel(userUseCase: r.resolve(UserUseCase.self)!, unitUseCase: r.resolve(FetchUnitUseCase.self)!, exerciseUseCase: r.resolve(FetchExerciseUseCase.self)!)}.inObjectScope(.container)
        //container.register(ListenAndRepeatViewModel.self) { r in ListenAndRepeatViewModel(repository: r.resolve(RepositoryProtocol.self)!)}
        container.register(ListenAndRepeatViewModel.self) { r in ListenAndRepeatViewModel(userUseCase: r.resolve(UserUseCase.self)!, unitUseCase: r.resolve(FetchUnitUseCase.self)!, exerciseUseCase: r.resolve(FetchExerciseUseCase.self)!)}
        container.register(ListenAndAnswerViewModel.self) { r in ListenAndAnswerViewModel(userUseCase: r.resolve(UserUseCase.self)!, unitUseCase: r.resolve(FetchUnitUseCase.self)!, exerciseUseCase: r.resolve(FetchExerciseUseCase.self)!)}
        container.register(RegisterViewModel.self) { r in
            RegisterViewModel(registerUseCase: r.resolve(RegisterUseCase.self)!)
        }
        return container
    }()
}
