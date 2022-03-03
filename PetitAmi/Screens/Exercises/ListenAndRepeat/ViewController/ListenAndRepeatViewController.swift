//
//  ListenAndRepeatViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import AVFoundation
import InstantSearchVoiceOverlay

class ListenAndRepeatViewController: UIViewController {
    
    let listenAndRepeatView = ListenAndRepeatView()
    let listenAndRepeatViewModel = AppContainer.shared.resolve(ListenAndRepeatViewModel.self)!
    var exerciseModel = ExerciseModel()
    var player: AVPlayer?
    
    let voiceOverlayController: VoiceOverlayController = {
        let recordableHandler = {
            return SpeechController(locale: Locale(identifier: "fr_FR"))
        }
        return VoiceOverlayController(speechControllerHandler: recordableHandler)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = listenAndRepeatView
        customizeNavigationBar()
        getDatas()
        voiceOverlaySettings()
        listenAndRepeatView.speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        listenAndRepeatView.micButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(micClicked)))
    }
    
    //MARK: - Actions
    
    func alert(title:String, message:String, next:Bool){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { alert in
            
        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getDatas(){
        listenAndRepeatViewModel.getData()
        listenAndRepeatView.activityIndicator.startAnimating()
        listenAndRepeatViewModel.onDataResults = { data in
            DispatchQueue.main.async {
                guard let exerciseModel = self.listenAndRepeatViewModel.exerciseModel else {
                    return
                }
                self.exerciseModel = exerciseModel
                self.listenAndRepeatView.activityIndicator.stopAnimating()
                self.listenAndRepeatView.exerciseImage.image = self.exerciseModel.image
                self.listenAndRepeatView.exerciseImage.isHidden = false
                self.listenAndRepeatView.speakerButton.tintColor = UIColor.systemRed
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

//MARK: - AVFoundation

extension ListenAndRepeatViewController {
    
    @objc func speakerClicked(){
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        listenAndRepeatView.speakerButton.image = K.waitingSoundIcon
        let sound = URL.init(string: exerciseModel.soundURL ?? "")
        let playerItem = AVPlayerItem.init(url: sound!)
        self.player = AVPlayer.init(playerItem: playerItem)
        setupAVPlayer()
        self.player!.play()
    }
    
    @objc func audioDidEnded(){
        listenAndRepeatView.speakerButton.image = K.defaultSoundIcon
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAVPlayer() {
        player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        self.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === self.player! {
            if player!.timeControlStatus == .playing {
                listenAndRepeatView.speakerButton.image = K.playingSoundIcon
            }
        }
    }
}

//MARK: - Instant Search VoiceOverlay

extension ListenAndRepeatViewController {
    
    func voiceOverlaySettings(){
        voiceOverlayController.settings.layout.inputScreen.subtitleInitial = ""
        voiceOverlayController.settings.layout.inputScreen.subtitleBullet = ""
        voiceOverlayController.settings.layout.inputScreen.subtitleBulletList = []
        guard let correctAnswer = exerciseModel.answer else {
            return
        }
        voiceOverlayController.settings.layout.inputScreen.titleInProgress = correctAnswer
        voiceOverlayController.settings.layout.inputScreen.titleListening = correctAnswer
    }
    
    @objc func micClicked(){
        voiceOverlayController.start(on: self, textHandler: { (text, finished ,any) in
            if finished {
                self.listenAndRepeatViewModel.checkAnswer(answer: text.lowercased())
                self.listenAndRepeatViewModel.onCheckAnswerResult = { correct in
                    DispatchQueue.main.async {
                        if correct {
                            guard let type = self.exerciseModel.nextExercise?.type else {
                                return
                            }
                            self.listenAndRepeatViewModel.goToNextExercise()
                            self.listenAndRepeatViewModel.onNextExerciseResult = {
                                DispatchQueue.main.async {
                                    type ? self.navigationController?.pushViewController(ListenAndAnswerViewController(), animated: true) : self.navigationController?.pushViewController(ListenAndRepeatViewController(), animated: true)
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.alert(title: "Resposta incorreta...", message: "Ops... Tente novamente!", next: false)
                            }
                            print(self.exerciseModel.answer, " vs ", text)
                        }
                    }
                }
            }
        }, errorHandler: { (error) in
            print("voice output: error \(String(describing: error))")
        })
    }
}
