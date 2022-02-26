//
//  ViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 25/02/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.primaryColor
    
        addComponents()
        addConstraints()
    }
    
    //MARK: - UI Components
    
    let titleLabel: UILabel = {
      let label = UILabel()
        label.text = "Bonjour, mon ami! Bienvenue sur votre app française."
        label.font = UIFont.systemFont(ofSize: 36.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    //MARK: - Adding constraints

    func addConstraints(){
        let viewHeightProportion = view.bounds.height/812.0
        let viewWidthProportion = view.bounds.width/375.0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeightProportion*290),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * 34),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: viewHeightProportion * 140),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * 128),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidthProportion * -128),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: viewHeightProportion * 12),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidthProportion * 128),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidthProportion * -128),
            
        ])
    }
}

