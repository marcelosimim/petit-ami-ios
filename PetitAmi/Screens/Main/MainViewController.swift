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
        addComponents()
        addConstraints()
    }
    
    //MARK: - Components
    
    let progressTitle: UILabel = {
       let label = UILabel()
        label.text = "Seu progresso:"
        //label.font = UIFont.systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

extension MainViewController: ViewConfiguration {
    func addComponents() {
        
    }
    
    func addConstraints() {
        
    }
}
