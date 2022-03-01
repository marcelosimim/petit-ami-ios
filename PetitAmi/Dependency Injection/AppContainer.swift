//
//  AppContainer.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()
        
        container.register(FirebaseProtocol.self) { _ in Firebase()}
        container.register(RepositoryProtocol.self) { r in
            Repository(firebase: r.resolve(FirebaseProtocol.self)!)
        }
        container.register(LoginViewModel.self) {_ in LoginViewModel()}
        container.register(HomeViewModel.self) {_ in HomeViewModel()}
        container.register(ListenAndRepeatViewModel.self) { r in ListenAndRepeatViewModel(repository: r.resolve(RepositoryProtocol.self)!)}
        container.register(ListenAndAnswerViewModel.self) { r in ListenAndAnswerViewModel(repository: r.resolve(RepositoryProtocol.self)!)}
        container.register(RegisterViewModel.self) { r in
            RegisterViewModel(repository: r.resolve(RepositoryProtocol.self)!)
        }
        return container
    }()
}
