//
//  ViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 25/02/22.
//

import UIKit

class InitialViewController: UIViewController {
    
    let initialView = InitialView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = initialView
        navigationItem.setHidesBackButton(true, animated: false)
        initialView.loginButton.addTarget(self, action: #selector(loginClicked), for: .touchDown)
        initialView.registerButton.addTarget(self, action: #selector(registerClicked), for: .touchDown)
    }
    
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
