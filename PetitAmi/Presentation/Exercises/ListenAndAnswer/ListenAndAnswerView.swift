//
//  ListenAndAnswerView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 24/03/22.
//

import UIKit

class ListenAndAnswerView: UIView {
    
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
    
    lazy var answerTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendAnswerButton: UIButton = {
       let button = UIButton()
        button.setTitle("ENVIAR", for: .normal)
        button.backgroundColor = K.buttonColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override func layoutSubviews() {
        backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    
    func addComponents() {
        addSubview(exerciseImage)
        addSubview(activityIndicator)
        addSubview(speakerButton)
        addSubview(answerTextField)
        addSubview(sendAnswerButton)
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
            speakerButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*50),
            answerTextField.topAnchor.constraint(equalTo: speakerButton.bottomAnchor, constant: K.viewHeightProportion*40),
            answerTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*52),
            answerTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            answerTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*30),
            sendAnswerButton.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: K.viewHeightProportion*56),
            sendAnswerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*128),
            sendAnswerButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
