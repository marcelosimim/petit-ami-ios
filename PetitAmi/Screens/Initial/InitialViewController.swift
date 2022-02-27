//
//  ViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 25/02/22.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        self.navigationItem.setHidesBackButton(true, animated: false)
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
        button.addTarget(self, action: #selector(loginClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registerButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = K.buttonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("CADASTRAR", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registerClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Actions
    
    @objc func loginClicked(){
        let newController = LoginViewController()
        navigationController?.pushViewController(newController, animated: true)
    }
    
    @objc func registerClicked(){
        let newController = RegisterViewController()
        navigationController?.pushViewController(newController, animated: true)
    }
}

//MARK: - View Configuration Protocol

extension InitialViewController: ViewConfiguration {
    func addComponents(){
        view.addSubview(homeImage)
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18.0*K.viewHeightProportion)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    func addConstraints(){
        let horizontalTitleDistance:CGFloat = 44
        let horizontalButtonDistance:CGFloat = 74
        
        NSLayoutConstraint.activate([
            homeImage.heightAnchor.constraint(equalToConstant: 300*K.viewHeightProportion),
            homeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*106),
            homeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * 25),
            homeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: homeImage.bottomAnchor, constant: K.viewHeightProportion*50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * horizontalTitleDistance),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.viewWidthProportion * horizontalTitleDistance * (-1)),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: K.viewHeightProportion * 100),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance*(-1)),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: K.viewHeightProportion * 12),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance * (-1)),
            
        ])
    }
}
