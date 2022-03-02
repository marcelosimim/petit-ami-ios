//
//  ListenAndAnswerViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 28/02/22.
//

import UIKit
import AVFoundation

class ListenAndAnswerViewController: UIViewController {
    
    let listenAndAnswerViewModel: ListenAndAnswerViewModel = AppContainer.shared.resolve(ListenAndAnswerViewModel.self)!
    var exerciseModel = ExerciseModel()
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
        getDatas()
    }
    
    let exerciseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView  = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    let speakerButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.defaultSoundIcon
        imageView.tintColor = UIColor(red: 0.796, green: 0.796, blue: 0.796, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var answerTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = K.textFieldColor
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var sendAnswerButton: UIButton = {
       let button = UIButton()
        button.setTitle("ENVIAR", for: .normal)
        button.backgroundColor = K.buttonColor
        button.addTarget(self, action: #selector(sendAnswerClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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

extension ListenAndAnswerViewController: ViewConfiguration {
    
    func getDatas(){
        listenAndAnswerViewModel.getData()
        activityIndicator.startAnimating()
        listenAndAnswerViewModel.onDataResults = { data in
            DispatchQueue.main.async {
                guard let exerciseModel = self.listenAndAnswerViewModel.exerciseModel else {
                    return
                }
                self.exerciseModel = exerciseModel
                self.activityIndicator.stopAnimating()
                self.exerciseImage.image = self.exerciseModel.image
                self.exerciseImage.isHidden = false
                self.speakerButton.tintColor = UIColor.systemRed
            }
        }
    }
    
    func addComponents() {
        view.addSubview(exerciseImage)
        view.addSubview(activityIndicator)
        view.addSubview(speakerButton)
        speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        speakerButton.isUserInteractionEnabled = true
        view.addSubview(answerTextField)
        view.addSubview(sendAnswerButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            exerciseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*110),
            exerciseImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*38),
            exerciseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exerciseImage.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*200),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: K.viewHeightProportion*220),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*38),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakerButton.topAnchor.constraint(equalTo: exerciseImage.bottomAnchor, constant: K.viewHeightProportion*54),
            speakerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*150),
            speakerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakerButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*50),
            answerTextField.topAnchor.constraint(equalTo: speakerButton.bottomAnchor, constant: K.viewHeightProportion*40),
            answerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*52),
            answerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerTextField.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*30),
            sendAnswerButton.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: K.viewHeightProportion*56),
            sendAnswerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*128),
            sendAnswerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
        answerTextField.resignFirstResponder()
        
        guard let answer = exerciseModel.answer, let answered = answerTextField.text else {
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
        speakerButton.image = K.waitingSoundIcon
        let sound = URL.init(string: exerciseModel.soundURL ?? "")
        let playerItem = AVPlayerItem.init(url: sound!)
        self.player = AVPlayer.init(playerItem: playerItem)
        setupAVPlayer()
        self.player!.play()
    }
    
    @objc func audioDidEnded(){
        speakerButton.image = K.defaultSoundIcon
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAVPlayer() {
        player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player! {
            if player!.timeControlStatus == .playing {
                speakerButton.image = K.playingSoundIcon
            }
        }
    }
}
