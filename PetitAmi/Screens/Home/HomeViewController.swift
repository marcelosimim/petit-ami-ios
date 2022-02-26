//
//  ViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 25/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let viewHeightProportion = UIScreen.main.bounds.height/812.0
    let viewWidthProportion = UIScreen.main.bounds.width/375.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
    
        addComponents()
        addConstraints()
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
    
    //MARK: - Adding components
    
    func addComponents(){
        view.addSubview(homeImage)
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18.0*viewHeightProportion)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    //MARK: - Adding constraints

    func addConstraints(){
        let horizontalTitleDistance:CGFloat = 44
        let horizontalButtonDistance:CGFloat = 74
        
        NSLayoutConstraint.activate([
            homeImage.heightAnchor.constraint(equalToConstant: 300*viewHeightProportion),
            homeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeightProportion*106),
            homeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * 25),
            homeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: homeImage.bottomAnchor, constant: viewHeightProportion*50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * horizontalTitleDistance),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidthProportion * horizontalTitleDistance * (-1)),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: viewHeightProportion * 100),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * horizontalButtonDistance),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidthProportion * horizontalButtonDistance*(-1)),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: viewHeightProportion * 12),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * horizontalButtonDistance),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidthProportion * horizontalButtonDistance * (-1)),
            
        ])
    }
}

