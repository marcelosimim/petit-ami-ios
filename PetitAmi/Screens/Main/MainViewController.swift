//
//  MainViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import Swinject
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        customizeNavigationBar()
        addComponents()
        addConstraints()
        loadCover()
        getUserProgress()
    }
    
    //MARK: - Components
    
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
    
    //MARK: - Navigation Bar
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        let signOut = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [signOut]
    }
    
    //MARK: - Actions
    
    @objc func addTapped() {
        do{
            try Auth.auth().signOut()
            let newController = InitialViewController()
            navigationController?.pushViewController(newController, animated: true)
        }catch let error {
            print(error)
        }
    }
    
    @objc func coverClicked(){
        let newController = ListenAndRepeatViewController()
        navigationController?.pushViewController(newController, animated: true)
    }
}

extension MainViewController: ViewConfiguration {
    
    func getUserProgress(){
        repository.getUserProgress { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.progressBar.progress = data
        }
    }
    
    func loadCover() {
        activityIndicator.startAnimating()
        
        repository.getCoverImage(for: 1) { data, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            
            self.coverImage.image = data
            self.coverImage.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func addComponents() {
        view.addSubview(progressTitle)
        view.addSubview(progressBar)
        view.addSubview(keepStudyingLabel)
        view.addSubview(coverImage)
        view.addSubview(activityIndicator)
        coverImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coverClicked)))
        coverImage.isUserInteractionEnabled = true
    }
    
    func addConstraints() {
        let horizontalDistance: CGFloat = 46
        NSLayoutConstraint.activate([
            progressTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70*K.viewHeightProportion),
            progressTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
            progressTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 24*K.viewHeightProportion),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 15*K.viewHeightProportion),
            keepStudyingLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 48*K.viewHeightProportion),
            keepStudyingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalDistance*K.viewWidthProportion),
            keepStudyingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImage.topAnchor.constraint(equalTo: keepStudyingLabel.bottomAnchor, constant: 24*K.viewHeightProportion),
            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 126*K.viewWidthProportion),
            coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 200*K.viewHeightProportion),
            activityIndicator.topAnchor.constraint(equalTo: keepStudyingLabel.bottomAnchor, constant: 100*K.viewHeightProportion),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 126*K.viewWidthProportion),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //activityIndicator.heightAnchor.constraint(equalToConstant: 200*K.viewHeightProportion)
        ])
    }
}
