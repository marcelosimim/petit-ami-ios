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
    var userModel:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        customizeNavigationBar()
        addComponents()
        addConstraints()
        getUserInfo()
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userInfoLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var keepStudingArea: UIView = {
        let view = UIView()
        view.layer.backgroundColor = K.areaColor?.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressTitle: UILabel = {
       let label = UILabel()
        label.text = "Progresso"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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
         label.text = "Continue estudando"
         label.numberOfLines = 0
         label.textColor = UIColor.white
         label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let coverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.contentMode = .scaleAspectFit
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
    
    lazy var unitArea: UIView = {
        let view = UIView()
        view.layer.backgroundColor = K.areaColor?.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
         label.text = "Unidades"
         label.textColor = UIColor.white
         label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
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
        view.addSubview(keepStudingArea)
        view.addSubview(progressTitle)
        view.addSubview(progressBar)
        view.addSubview(coverImage)
        view.addSubview(activityIndicator)
        view.addSubview(keepStudyingLabel)
        view.addSubview(unitArea)
        view.addSubview(unitLabel)
        coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverClicked)))
        coverImage.isUserInteractionEnabled = true
    }
    
    func addConstraints() {
        let imageSize: CGFloat = K.viewWidthProportion*100
        let horizontalDistance: CGFloat = 20
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
            keepStudingArea.topAnchor.constraint(equalTo: headerArea.bottomAnchor, constant: K.viewHeightProportion*32),
            keepStudingArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*horizontalDistance),
            keepStudingArea.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keepStudingArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*280),
            progressTitle.topAnchor.constraint(equalTo: keepStudingArea.topAnchor, constant: 16*K.viewHeightProportion),
            progressTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46*K.viewWidthProportion),
            progressTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 12*K.viewHeightProportion),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46*K.viewWidthProportion),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 10*K.viewHeightProportion),
            coverImage.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30*K.viewHeightProportion),
            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130*K.viewWidthProportion),
            coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 150*K.viewHeightProportion),
            activityIndicator.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 90*K.viewHeightProportion),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130*K.viewWidthProportion),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keepStudyingLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 10*K.viewHeightProportion),
            keepStudyingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
            unitArea.topAnchor.constraint(equalTo: keepStudingArea.bottomAnchor, constant: K.viewHeightProportion*32),
            unitArea.leadingAnchor.constraint(equalTo: keepStudingArea.leadingAnchor),
            unitArea.trailingAnchor.constraint(equalTo: keepStudingArea.trailingAnchor),
            unitArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*230),
            unitLabel.topAnchor.constraint(equalTo: unitArea.topAnchor, constant: K.viewHeightProportion*16),
            unitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46*K.viewWidthProportion),
            unitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

//MARK: - View Model

extension HomeViewController {
    func getUserInfo(){
        homeViewModel.getUserInfo()
        homeViewModel.userInfoCompletion = {
            DispatchQueue.main.async {
                self.userModel = self.homeViewModel.userModel
                self.welcomeLabel.text = "Bienvenue, \(self.userModel?.name ?? "user")!"
                self.userInfoLabel.text = "Unidade atual: \(self.userModel?.unit ?? 0)\nExercício atual: \(self.userModel?.exercise ?? 0)\nNível do francês: \(self.homeViewModel.frenchLevel())"
                self.progressBar.progress = Float((self.userModel?.unit)!)/96.0
                self.loadCover()
                self.fetchCarousel()
            }
        }
    }
    
    func loadCover() {
        activityIndicator.startAnimating()
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
    
    func fetchCarousel() {
        homeViewModel.fetchCarousel(unit: 1)
        homeViewModel.onFetchCarousel = {
            
        }
    }
}
