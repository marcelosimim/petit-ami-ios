//
//  ListenAndRepeatViewController.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 26/02/22.
//

import UIKit
import AVFoundation

class ListenAndRepeatViewController: UIViewController {
    
    let repository: RepositoryProtocol = AppContainer.shared.resolve(RepositoryProtocol.self)!
    var soundURL: String = ""
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.backgroundColor
        getDatas()
        addComponents()
        addConstraints()
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
    
    func addComponents() {
        view.addSubview(exerciseImage)
        view.addSubview(activityIndicator)
        view.addSubview(speakerButton)
        speakerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(speakerClicked)))
        speakerButton.isUserInteractionEnabled = true
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
