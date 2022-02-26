//
//  MainViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        
        customizeNavigationBar()
    }
    
    //MARK: - Navigation Bar
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        let signOut = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [signOut]
    }
    
    //MARK: - Actions
    
    @objc func addTapped() {
        do{
            try Auth.auth().signOut()
            let newController = HomeViewController()
            navigationController?.pushViewController(newController, animated: true)
        }catch let error {
            print(error)
        }
    }
}
