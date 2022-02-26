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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        customizeNavigationBar()
        addComponents()
        addConstraints()
        loadCover()
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
        progressView.progress = 0.8
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
        imageView.image = UIImage(systemName: "xmark.octagon")
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
            let newController = HomeViewController()
            navigationController?.pushViewController(newController, animated: true)
        }catch let error {
            print(error)
        }
    }
    
    @objc func coverClicked(){
        
    }
}

extension MainViewController: ViewConfiguration {
    func loadCover() {
        let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!
        repository.getCoverImage(for: 1) { data, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            
            self.coverImage.image = data
        }
    }
    
    func addComponents() {
        view.addSubview(progressTitle)
        view.addSubview(progressBar)
        view.addSubview(keepStudyingLabel)
        view.addSubview(coverImage)
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
            coverImage.heightAnchor.constraint(equalToConstant: 160*K.viewHeightProportion)
        ])
    }
}
