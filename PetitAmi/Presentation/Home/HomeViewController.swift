//
//  MainViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import Swinject

class HomeViewController: UIViewController {
    
    var user:User?
    let homeView = HomeView()
    let homeViewModel = AppContainer.shared.resolve(HomeViewModel.self)!
    var currentExerciseType:Bool?
    let imagePickerController = UIImagePickerController()
    let cameraPickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        customizeNavigationBar()
        configurePickers()
        getUserInfo()
        homeView.perfilArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(perfilClicked)))
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
    
    @objc func perfilClicked(){
        let actionSheet = UIAlertController(title: "Escolha a fonte", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            self.present(self.cameraPickerController, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Biblioteca", style: .default, handler: { _ in
            self.present(self.imagePickerController, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(actionSheet, animated: true)
        //present(imagePickerController, animated: true)
    }
    
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
                self.user = self.homeViewModel.user
                self.homeView.perfilArea.image = UIImage(data: (self.user?.photo)!)
                self.configureImage()
                self.homeView.welcomeLabel.text = "Bienvenue, \(self.user?.name ?? "user")!"
                self.homeView.userInfoLabel.text = "Unidade atual: \(self.user?.unit ?? 0)\nExercício atual: \(self.user?.exercise ?? 0)\nNível do francês: \(self.homeViewModel.frenchLevel())"
                self.homeView.progressBar.progress = Float((self.user?.unit)!)/96.0
                self.getCurrentExercise()
                self.loadCover()
                self.fetchCarousel()
            }
        }
    }

    func loadCover() {
        homeView.activityIndicator.startAnimating()
        guard let unit = user?.unit else {
            return
        }
        homeViewModel.loadCover(unit: unit)
        homeViewModel.loadCoverCompletion = { data in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                self.homeView.coverImage.image = UIImage(data: data)
                self.homeView.coverImage.isHidden = false
                self.homeView.activityIndicator.stopAnimating()
            }
        }
    }

    func getCurrentExercise() {
        homeViewModel.getExercise()
        homeViewModel.onResults = {
            DispatchQueue.main.async {
                self.currentExerciseType = self.homeViewModel.exercise?.type
            }
        }
    }

    func fetchCarousel() {
        homeViewModel.fetchCarousel(unit: 1)
        homeViewModel.onFetchCarousel = {

        }
    }
    
    func uploadPhoto(image: Data){
        homeViewModel.uploadPhoto(image: image)
    }
}

// MARK: - Image Picker

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func configureImage(){
        homeView.perfilArea.layer.cornerRadius = homeView.perfilArea.frame.size.width / 2
        homeView.perfilArea.clipsToBounds = true
        homeView.perfilArea.contentMode = .scaleAspectFill
    }
    
    func configurePickers() {
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        cameraPickerController.allowsEditing = true
        cameraPickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraPickerController.sourceType = .camera
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        uploadPhoto(image: image.pngData()!)
        homeViewModel.uploadFinished = {
            self.homeView.perfilArea.image = image
            self.configureImage()
        }
        dismiss(animated: true)
    }
}
