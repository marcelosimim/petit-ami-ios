//
//  RegisterViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerViewModel = AppContainer.shared.resolve(RegisterViewModel.self)!

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
        textField.autocapitalizationType = .none
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
        button.addTarget(self, action: #selector(sendButtonClicked), for: .touchDown)
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
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*130),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: top),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: top),
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
                guard let email = emailTextField.text else {
                    setInvalidTextField(emailTextField)
                    return true
                }
                email.isValidEmail() ? setValidTextField(emailTextField) : setInvalidTextField(emailTextField)
                break
            case nameTextField:
                guard let name = nameTextField.text else {
                    setInvalidTextField(nameTextField)
                    return true
                }
                name != "" ? setValidTextField(nameTextField) : setInvalidTextField(nameTextField)
                break
            default:
                break
        }
        return true
    }
}

//MARK: - Validations

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension RegisterViewController {
    
    func setValidTextField(_ textField:UITextField) {
        textField.layer.borderWidth = 0
    }
    
    func setInvalidTextField(_ textField:UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    func isValidName(_ name: String) -> Bool {
        name.count > 0
    }
    
    func passwordMatch(password:String, confirmPassword: String) -> Bool {
        password == confirmPassword
    }
    
    @objc func sendButtonClicked() {
        registerViewModel.register(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        registerViewModel.onRegisterCompleted = { error in
            guard let error = error else {
                let newController = HomeViewController()
                self.navigationController?.pushViewController(newController, animated: true)
                return
            }
            self.showAlert(with: error.localizedDescription)
        }
    }
    
    //MARK: - Alert
    
    func showAlert(with message:String){
        let alert = UIAlertController(title: "Erro ao logar", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
