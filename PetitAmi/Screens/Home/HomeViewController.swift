//
//  MainViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import Swinject

class HomeViewController: UIViewController {
    
    var userModel:UserModel?
    let homeView = HomeView()
    let homeViewModel = AppContainer.shared.resolve(HomeViewModel.self)!
    var currentExerciseType:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        customizeNavigationBar()
        getUserInfo()
        getCurrentExercise()
        homeView.coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverClicked)))
    }
    
    //MARK: - Navigation Bar
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        let signOut = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(signOutTapped))
        navigationItem.rightBarButtonItems = [signOut]
        navigationItem.leftBarButtonItems = []
    }
    
    //MARK: - Actions
    
    @objc func coverClicked(){
        guard let currentExerciseType = currentExerciseType else {
            return
        }
        
        currentExerciseType ? navigationController?.pushViewController(ListenAndAnswerViewController(), animated: true) : navigationController?.pushViewController(ListenAndRepeatViewController(), animated: true)
    }
    
    @objc func signOutTapped(){
        homeViewModel.signOutButtonTapped()
        homeViewModel.signOutCompletion = { error in
            DispatchQueue.main.async {
                guard let error = error else {
                    self.navigationController?.pushViewController(InitialViewController(), animated: true)
                    return
                }
                print(error)
            }
        }
    }
}

//MARK: - View Model

extension HomeViewController {
    func getUserInfo(){
        homeViewModel.getUserInfo()
        homeViewModel.userInfoCompletion = {
            DispatchQueue.main.async {
                self.userModel = self.homeViewModel.userModel
                self.homeView.welcomeLabel.text = "Bienvenue, \(self.userModel?.name ?? "user")!"
                self.homeView.userInfoLabel.text = "Unidade atual: \(self.userModel?.unit ?? 0)\nExercício atual: \(self.userModel?.exercise ?? 0)\nNível do francês: \(self.homeViewModel.frenchLevel())"
                self.homeView.progressBar.progress = Float((self.userModel?.unit)!)/96.0
                self.loadCover()
                self.fetchCarousel()
            }
        }
    }

    func loadCover() {
        homeView.activityIndicator.startAnimating()
        guard let unit = userModel?.unit else {
            return
        }
        homeViewModel.loadCover(unit: unit)
        homeViewModel.loadCoverCompletion = { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print(error)
                    return
                }
                self.homeView.coverImage.image = data
                self.homeView.coverImage.isHidden = false
                self.homeView.activityIndicator.stopAnimating()
            }
        }
    }

    func getCurrentExercise() {
        homeViewModel.getExercise()
        homeViewModel.onResults = {
            DispatchQueue.main.async {
                self.currentExerciseType = self.homeViewModel.exerciseModel?.type
            }
        }
    }

    func fetchCarousel() {
        homeViewModel.fetchCarousel(unit: 1)
        homeViewModel.onFetchCarousel = {

        }
    }
}
