//
//  LoginViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginViewModel = AppContainer.shared.resolve(LoginViewModel.self)!
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view = loginView
        loginView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchDown)
    }
    
    //MARK: - Actions
    
    @objc func loginPressed(){
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else {
            return
        }
        
        loginViewModel.login(with: email, and: password)
        
        loginViewModel.loginSuccedd = {
            let newController = HomeViewController()
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
