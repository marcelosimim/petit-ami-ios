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
        
        return container
    }()
}
