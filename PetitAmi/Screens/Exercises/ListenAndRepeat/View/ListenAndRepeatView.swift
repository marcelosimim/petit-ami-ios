//
//  ListenAndRepeatView.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 03/03/22.
//

import UIKit

class ListenAndRepeatView: UIView {

    override func layoutSubviews() {
        backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    //MARK: - UI Components
    
    lazy var exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView  = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    lazy var speakerButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.defaultSoundIcon
        imageView.tintColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var micButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.defaultMicIcon
        imageView.tintColor = UIColor.red
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

//MARK: - View Configuration Protocol

extension ListenAndRepeatView: ViewConfiguration {
    
    func addComponents() {
        addSubview(exerciseImage)
        addSubview(activityIndicator)
        addSubview(speakerButton)
        addSubview(micButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            exerciseImage.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*110),
            exerciseImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*38),
            exerciseImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            exerciseImage.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*200),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*220),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*38),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            speakerButton.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: K.viewHeightProportion*54),
            speakerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*150),
            speakerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            speakerButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*65),
            micButton.topAnchor.constraint(equalTo: bottomAnchor, constant: K.viewHeightProportion*70*(-1)),
            micButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*170),
            micButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            micButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*40),
        ])
    }
}
