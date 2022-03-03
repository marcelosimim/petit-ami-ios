//
//  InitialView.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 03/03/22.
//

import UIKit

class InitialView: UIView {

    override func layoutSubviews() {
        addComponents()
        addConstraints()
        backgroundColor = K.backgroundColor
    }
    
    //MARK: - UI Components
    
    let homeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.homeImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
      let label = UILabel()
        label.text = "Bonjour, mon ami! \nBienvenue sur votre app française."
        label.font = UIFont.systemFont(ofSize: 18.0*K.viewHeightProportion)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = K.buttonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("ENTRAR", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = K.buttonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("CADASTRAR", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}


//MARK: - View Configuration Protocol

extension InitialView: ViewConfiguration {
    func addComponents(){
        addSubview(homeImage)
        addSubview(titleLabel)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func addConstraints(){
        let horizontalTitleDistance:CGFloat = 44
        let horizontalButtonDistance:CGFloat = 74
        
        NSLayoutConstraint.activate([
            homeImage.heightAnchor.constraint(equalToConstant: 300*K.viewHeightProportion),
            homeImage.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*106),
            homeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * 25),
            homeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: homeImage.bottomAnchor, constant: K.viewHeightProportion*50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * horizontalTitleDistance),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: K.viewWidthProportion * horizontalTitleDistance * (-1)),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: K.viewHeightProportion * 100),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance*(-1)),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: K.viewHeightProportion * 12),
            registerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            registerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance * (-1)),
            
        ])
    }
}
