//
//  RegisterViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastro"
        view.backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Insira o email"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.keyboardType = .emailAddress
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Insira seu nome"
        textField.backgroundColor = K.textFieldColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
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
    
}

extension RegisterViewController: ViewConfiguration {
    
    func addComponents() {
        view.addSubview(emailTextField)
        view.addSubview(nameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(sendButton)
    }
    
    func addConstraints() {
        let leading: CGFloat = K.viewWidthProportion * 42
        let top: CGFloat = K.viewHeightProportion * 42
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*130),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: top),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: top),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: top),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            nameTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            passwordTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*42),
            sendButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: top),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*128),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
            case emailTextField:
                print("email")
                break
            case nameTextField:
                print("name")
                break
            case passwordTextField:
                print("password")
                break
            case confirmPasswordTextField:
                print("confirm")
                break
            default:
                break
        }
        
        return true
    }
}
