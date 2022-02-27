//
//  LoginViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = K.backgroundColor
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
        button.addTarget(self, action: #selector(loginPressed), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Actions
    
    @objc func loginPressed(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        loginViewModel.login(with: email, and: password)
        
        loginViewModel.loginSuccedd = {
            let newController = MainViewController()
            self.navigationController?.pushViewController(newController, animated: true)
        }
        
        loginViewModel.loginWithError = { error in 
            self.showAlert(with: error?.localizedDescription ?? "Erro não identificado.")
        }
        
    }
    
    //MARK: - Alert
    
    func showAlert(with message:String){
        let alert = UIAlertController(title: "Erro ao logar", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - View Configuration Protocol

extension LoginViewController: ViewConfiguration {
    
    func addComponents(){
        view.addSubview(loginImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }

    func addConstraints(){
        let horizontalTitleDistance:CGFloat = 44
        let horizontalButtonDistance:CGFloat = 74
        
        NSLayoutConstraint.activate([
            loginImage.heightAnchor.constraint(equalToConstant: 180*K.viewHeightProportion),
            loginImage.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*120),
            loginImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * 25),
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: loginImage.bottomAnchor, constant: K.viewHeightProportion*168),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: K.viewWidthProportion*44),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: K.viewHeightProportion*50),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: K.viewWidthProportion*44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: K.viewHeightProportion * 50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.viewWidthProportion * horizontalButtonDistance*(-1)),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
}
