//
//  RegisterView.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 24/03/22.
//

import UIKit

class RegisterView: UIView {

    lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Insira o email"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Insira seu nome"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Insira a senha"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Confirme a senha"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendButton: UIButton = {
       let button = UIButton()
        button.setTitle("ENVIAR", for: .normal)
        button.backgroundColor = K.buttonColor
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    func addComponents() {
        addSubview(emailTextField)
        addSubview(nameTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(sendButton)
    }
    
    func addConstraints() {
        let leading: CGFloat = K.viewWidthProportion * 42
        let top: CGFloat = K.viewHeightProportion * 42
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*130),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: top),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: top),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: top),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            nameTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            passwordTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            sendButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: top),
            sendButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*128),
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
