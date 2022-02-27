//
//  ListenAndRepeatViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class ListenAndRepeatViewController: UIViewController {
    
    let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        setViewTitle()
        addComponents()
        addConstraints()
    }
    
    //MARK: - UI Components
    
    let exerciseImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView  = {
       let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    let speakerButton: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(systemName: "speaker.wave.2.fill")
         imageView.tintColor = UIColor.systemRed
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    //MARK: - Actions
    
    @objc func speakerClicked(){
        print("som")
    }
    
}

//MARK: - View Configuration Protocol

extension ListenAndRepeatViewController: ViewConfiguration {
    
    func setViewTitle(){
        repository.getUnitAndExercise { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.title = "Unité \(data[0]) - \(data[1])"
            self.loadExerciseImage(unit: data[0], exercise: data[1])
        }
    }
    
    func loadExerciseImage(unit:Int, exercise: Int){
        activityIndicator.startAnimating()
        
        repository.getExerciseImage(unit: unit, exercise: exercise) { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.exerciseImage.image = data
            self.exerciseImage.isHidden = false
        }
    }
    
    func addComponents() {
        view.addSubview(exerciseImage)
        view.addSubview(activityIndicator)
        view.addSubview(speakerButton)
        speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        speakerButton.isUserInteractionEnabled = true
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            exerciseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*110),
            exerciseImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*38),
            exerciseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exerciseImage.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*200),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*220),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*38),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakerButton.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: K.viewHeightProportion*54),
            speakerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*150),
            speakerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakerButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*65),
            
        ])
    }
}
