//
//  MainViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import Swinject

class HomeViewController: UIViewController {
    
    let homeViewModel = AppContainer.shared.resolve(HomeViewModel.self)!
    var currentExerciseType:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        customizeNavigationBar()
        addComponents()
        addConstraints()
        loadCover()
        getUserProgress()
        getCurrentExercise()
    }
    
    //MARK: - Components
    
    lazy var headerArea: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.headerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var perfilArea: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.perfilAreaImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
       let label = UILabel()
        label.text = "Bienvenue, user!"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userInfoLabel: UILabel = {
       let label = UILabel()
        label.text = "Unidade atual: 1\nExercício atual: 1\nNível do francês: Básico"
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressTitle: UILabel = {
       let label = UILabel()
        label.text = "Seu progresso:"
        label.font = UIFont.systemFont(ofSize: K.viewHeightProportion*20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
       let progressView = UIProgressView()
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5
        progressView.progress = 0.0
        progressView.trackTintColor = K.progressBarTrack
        progressView.progressTintColor = K.progressBarProgress
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let keepStudyingLabel: UILabel = {
        let label = UILabel()
         label.text = "Continue estudando:"
         label.font = UIFont.systemFont(ofSize: K.viewHeightProportion*20, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let coverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView  = {
       let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    //MARK: - Navigation Bar
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        let signOut = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(signOutTapped))
        navigationItem.rightBarButtonItems = [signOut]
    }
    
    //MARK: - Actions
    
    @objc func coverClicked(){
        guard let currentExerciseType = currentExerciseType else {
            return
        }

        if currentExerciseType {
            let newController = ListenAndAnswerViewController()
            navigationController?.pushViewController(newController, animated: true)
        }else {
            let newController = ListenAndRepeatViewController()
            navigationController?.pushViewController(newController, animated: true)
        }
    }
    
    @objc func signOutTapped(){
        homeViewModel.signOutButtonTapped()
        homeViewModel.signOutCompletion = { error in
            DispatchQueue.main.async {
                guard let error = error else {
                    let newController = InitialViewController()
                    self.navigationController?.pushViewController(newController, animated: true)
                    return
                }
                print(error)
            }
        }
    }
}

//MARK: - View Configuration

extension HomeViewController: ViewConfiguration {
    func addComponents() {
        view.addSubview(headerArea)
        view.addSubview(perfilArea)
        view.addSubview(welcomeLabel)
        view.addSubview(userInfoLabel)
//        view.addSubview(progressTitle)
//        view.addSubview(progressBar)
//        view.addSubview(keepStudyingLabel)
//        view.addSubview(coverImage)
//        view.addSubview(activityIndicator)
//        coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverClicked)))
//        coverImage.isUserInteractionEnabled = true
    }
    
    func addConstraints() {
        let imageSize: CGFloat = K.viewWidthProportion*100
        let horizontalDistance: CGFloat = 46
        NSLayoutConstraint.activate([
            headerArea.topAnchor.constraint(equalTo: view.topAnchor),
            headerArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*200),
            perfilArea.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*60),
            perfilArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*24),
            perfilArea.heightAnchor.constraint(equalToConstant: imageSize),
            perfilArea.widthAnchor.constraint(equalToConstant: imageSize),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*80),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*138),
            userInfoLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: K.viewHeightProportion*10),
            userInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*138),
            
            //            progressTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70*K.viewHeightProportion),
//            progressTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
//            progressTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            progressBar.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 24*K.viewHeightProportion),
//            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
//            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            progressBar.heightAnchor.constraint(equalToConstant: 15*K.viewHeightProportion),
//            keepStudyingLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 48*K.viewHeightProportion),
//            keepStudyingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
//            keepStudyingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            coverImage.topAnchor.constraint(equalTo: keepStudyingLabel.bottomAnchor, constant: 24*K.viewHeightProportion),
//            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 126*K.viewWidthProportion),
//            coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            coverImage.heightAnchor.constraint(equalToConstant: 200*K.viewHeightProportion),
//            activityIndicator.topAnchor.constraint(equalTo: keepStudyingLabel.bottomAnchor, constant: 100*K.viewHeightProportion),
//            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 126*K.viewWidthProportion),
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

//MARK: - View Model

extension HomeViewController {
    func getUserProgress(){
        homeViewModel.getUserProgress()
        homeViewModel.userProgressCompletion = { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print(error)
                    return
                }
                self.progressBar.progress = data
            }
        }
    }
    
    func loadCover() {
        activityIndicator.startAnimating()
        
        homeViewModel.loadCover()
        homeViewModel.loadCoverCompletion = { data, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print(error)
                    return
                }
                self.coverImage.image = data
                self.coverImage.isHidden = false
                self.activityIndicator.stopAnimating()
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
}
