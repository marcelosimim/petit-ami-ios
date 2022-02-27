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
    
    let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!
    var soundURL: String = ""
    var player: AVPlayer?
    var correctAnswer = ""
    var exerciseType = false
    
    let voiceOverlayController: VoiceOverlayController = {
          let recordableHandler = {
            return SpeechController(locale: Locale(identifier: "fr_FR"))
          }
          return VoiceOverlayController(speechControllerHandler: recordableHandler)
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        getDatas()
        addComponents()
        addConstraints()
        voiceOverlaySettings()
    }
    
    //MARK: - UI Components
    
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
    
    let micButton: UIImageView = {
        let imageView = UIImageView()
         imageView.image = K.defaultMicIcon
        imageView.tintColor = UIColor.red
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    //MARK: - Actions
    
    @objc func speakerClicked(){
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        speakerButton.image = K.waitingSoundIcon
        let sound = URL.init(string: soundURL)
        let playerItem = AVPlayerItem.init(url: sound!)
        self.player = AVPlayer.init(playerItem: playerItem)
        setupAVPlayer()
        self.player!.play()
    }
    
    func alert(title:String, message:String){
            let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }
    
    @objc func micClicked(){
        voiceOverlayController.start(on: self, textHandler: { (text, finished ,any) in
            print("voice output: \(String(describing: text))")
            print("voice output: is it final? \(String(describing: finished))")
            if finished {
                if text.lowercased() == self.correctAnswer.lowercased() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.alert(title: "Resposta correta!", message: "Parabéns! Voce acertou!")
                     }
                    
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.alert(title: "Resposta incorreta...", message: "Ops... Tente novamente!")
                    }
                    print(self.correctAnswer, " vs ", text)
                }
            }
                }, errorHandler: { (error) in
                    print("voice output: error \(String(describing: error))")
                })
    }
}

//MARK: - View Configuration Protocol

extension ListenAndRepeatViewController: ViewConfiguration {
    
    func getDatas(){
        repository.getUnitAndExercise { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.title = "Unité \(data[0]) - \(data[1])"
            self.loadExerciseImage(unit: data[0], exercise: data[1])
            self.getExerciseSound(unit: data[0], exercise: data[1])
            self.getExerciseAnswer(unit: data[0], exercise: data[1])
        }
    }
    
    func loadExerciseImage(unit:Int, exercise: Int){
        activityIndicator.startAnimating()
        
        repository.getExerciseImage(unit: unit, exercise: exercise) { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.exerciseImage.image = data
            self.exerciseImage.isHidden = false
        }
    }
    
    func getExerciseSound(unit:Int, exercise: Int){
        repository.getExerciseSound(unit: unit, exercise: exercise) { url, error in
            guard let url = url else {
                return
            }
            self.soundURL = url
            self.speakerButton.tintColor = UIColor.systemRed
        }
    }
    
    func getExerciseAnswer(unit:Int, exercise: Int){
        repository.getExerciseAnswer(unit: unit, exercise: exercise) { answer, type, error in
            guard let answer = answer, let type = type else {
                return
            }
            
            self.correctAnswer = answer
            self.exerciseType = type
        }
    }
    
    func addComponents() {
        view.addSubview(exerciseImage)
        view.addSubview(activityIndicator)
        view.addSubview(speakerButton)
        speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        speakerButton.isUserInteractionEnabled = true
        view.addSubview(micButton)
        micButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(micClicked)))
        micButton.isUserInteractionEnabled = true
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
            speakerButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*65),
            micButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: K.viewHeightProportion*70*(-1)),
            micButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.viewWidthProportion*170),
            micButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            micButton.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*40),
        ])
    }
}

//MARK: - AVFoundation

extension ListenAndRepeatViewController {
    
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

//MARK: - Instant Search VoiceOverlay

extension ListenAndRepeatViewController {
    func voiceOverlaySettings(){
            voiceOverlayController.settings.layout.inputScreen.subtitleInitial = ""
            voiceOverlayController.settings.layout.inputScreen.subtitleBullet = ""
            voiceOverlayController.settings.layout.inputScreen.subtitleBulletList = []
            voiceOverlayController.settings.layout.inputScreen.titleInProgress = correctAnswer
            voiceOverlayController.settings.layout.inputScreen.titleListening = correctAnswer
    }
    
    
}
