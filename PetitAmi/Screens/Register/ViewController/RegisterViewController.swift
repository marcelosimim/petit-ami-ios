//
//  RegisterViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let registerViewModel = AppContainer.shared.resolve(RegisterViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cadastro" 
        view = registerView
        registerView.emailTextField.delegate = self
        registerView.nameTextField.delegate = self
        registerView.sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchDown)
    }
}

//MARK: - TextField Delegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case registerView.emailTextField:
            guard let email = registerView.emailTextField.text else {
                setInvalidTextField(registerView.emailTextField)
                    return true
                }
            email.isValidEmail() ? setValidTextField(registerView.emailTextField) : setInvalidTextField(registerView.emailTextField)
                break
        case registerView.nameTextField:
            guard let name = registerView.nameTextField.text else {
                setInvalidTextField(registerView.nameTextField)
                    return true
                }
            name != "" ? setValidTextField(registerView.nameTextField) : setInvalidTextField(registerView.nameTextField)
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
        registerViewModel.register(name: registerView.nameTextField.text!, email: registerView.emailTextField.text!, password: registerView.passwordTextField.text!)
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
