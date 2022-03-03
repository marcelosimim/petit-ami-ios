//
//  LoginView.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 03/03/22.
//

import UIKit

class LoginView: UIView {

    override func layoutSubviews() {
        backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    //MARK: - UI Components
    
    let loginImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.loginImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailTextField: UITextField = {
       let textField = UITextField()
        textField.text = "marcelo@adm.com"
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 8
        textField.layer.backgroundColor = K.textFieldColor?.cgColor
        textField.textColor = UIColor.white
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.text = "123456"
        textField.placeholder = "Senha"
        textField.layer.cornerRadius = 8
        textField.layer.backgroundColor = K.textFieldColor?.cgColor
        textField.textColor = UIColor.white
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
}

//MARK: - View Configuration Protocol

extension LoginView: ViewConfiguration {
    
    func addComponents(){
        addSubview(loginImage)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
    }

    func addConstraints(){
        let horizontalTitleDistance:CGFloat = 44
        let horizontalButtonDistance:CGFloat = 74
        
        NSLayoutConstraint.activate([
            loginImage.heightAnchor.constraint(equalToConstant: 180*K.viewHeightProportion),
            loginImage.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*120),
            loginImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * 25),
            loginImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: K.viewHeightProportion*168),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: K.viewWidthProportion*44),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: K.viewHeightProportion*50),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: K.viewWidthProportion*44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: K.viewHeightProportion * 50),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance*(-1)),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
}

