//
//  ListenAndAnswerViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 28/02/22.
//

import UIKit
import AVFoundation

class ListenAndAnswerViewController: UIViewController {
    
    let listenAndAnswerView = ListenAndAnswerView()
    let listenAndAnswerViewModel: ListenAndAnswerViewModel = AppContainer.shared.resolve(ListenAndAnswerViewModel.self)!
    var exerciseModel = Exercise()
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = listenAndAnswerView
        listenAndAnswerView.sendAnswerButton.addTarget(self, action: #selector(sendAnswerClicked), for: .touchDown)
        listenAndAnswerView.speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        listenAndAnswerView.answerTextField.delegate = self
        getDatas()
    }
    
    //MARK: - Action
    
    @objc func sendAnswerClicked() {
        
    }
    
    func alert(title:String, message:String, next:Bool){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { alert in
            
        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ListenAndAnswerViewController {
    
    func getDatas(){
        listenAndAnswerViewModel.getData()
        listenAndAnswerView.activityIndicator.startAnimating()
        listenAndAnswerViewModel.onDataResults = { data in
            DispatchQueue.main.async {
                guard let exerciseModel = self.listenAndAnswerViewModel.exercise else {
                    return
                }
                self.exerciseModel = exerciseModel
                self.listenAndAnswerView.activityIndicator.stopAnimating()
                self.listenAndAnswerView.exerciseImage.image = UIImage(data: self.exerciseModel.image!)
                self.listenAndAnswerView.exerciseImage.isHidden = false
                self.listenAndAnswerView.speakerButton.tintColor = UIColor.systemRed
            }
        }
    }
    
    func customizeNavigationBar(){
        self.navigationItem.setHidesBackButton(true, animated: false)
        let signOut = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(goBackToHome))
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = [signOut]
    }
    
    @objc func goBackToHome() {
        let controller = HomeViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListenAndAnswerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        listenAndAnswerView.answerTextField.resignFirstResponder()
        
        guard let answer = exerciseModel.answer, let answered = listenAndAnswerView.answerTextField.text else {
            return true
        }
        
        if answered.lowercased() == answer.lowercased() {
            guard let type = self.exerciseModel.nextExercise?.type else {
                return true
            }
            self.listenAndAnswerViewModel.goToNextExercise()
            self.listenAndAnswerViewModel.onNextExerciseResult = {
                DispatchQueue.main.async {
                    if type {
                        let newController = ListenAndAnswerViewController()
                        self.navigationController?.pushViewController(newController, animated: true)
                    }else {
                        print("new view conroller")
                        let newController = ListenAndRepeatViewController()
                        self.navigationController?.pushViewController(newController, animated: true)
                    }
                }
            }
        }else{
            print(answer, " vs ", answered)
            self.alert(title: "Resposta incorreta...", message: "Ops... Tente novamente!", next: false)
        }
        
        return true
    }
    
}

//MARK: - AVFoundation

extension ListenAndAnswerViewController {
    
    @objc func speakerClicked(){
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        listenAndAnswerView.speakerButton.image = K.waitingSoundIcon
        let sound = URL.init(string: exerciseModel.soundURL ?? "")
        let playerItem = AVPlayerItem.init(url: sound!)
        self.player = AVPlayer.init(playerItem: playerItem)
        setupAVPlayer()
        self.player!.play()
    }
    
    @objc func audioDidEnded(){
        listenAndAnswerView.speakerButton.image = K.defaultSoundIcon
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAVPlayer() {
        player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player! {
            if player!.timeControlStatus == .playing {
                listenAndAnswerView.speakerButton.image = K.playingSoundIcon
            }
        }
    }
}
