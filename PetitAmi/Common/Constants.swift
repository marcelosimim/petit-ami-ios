//
//  Constants.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 25/02/22.
//

import Foundation
import UIKit

class K {
    
    //MARK: - Device
    static let viewHeightProportion = UIScreen.main.bounds.height/812.0
    static let viewWidthProportion = UIScreen.main.bounds.width/375.0
    
    //MARK: - Colors
    static let backgroundColor = UIColor(named: "Background")
    static let areaColor = UIColor(named: "Area")
    static let primaryColor = UIColor(named: "Primary")
    static let buttonColor = UIColor(named: "Button")
    static let textFieldColor = UIColor(named: "TextField")
    static let progressBarProgress = UIColor(named: "ProgressBarProgress")
    static let progressBarTrack = UIColor(named: "ProgressBarTrack")
    
    //MARK: - Images
    static let logoImage = UIImage(named: "Logo")
    static let homeImage = UIImage(named: "Reading")
    static let loginImage = UIImage(named: "Login")
    static let notFoundedImage = UIImage(systemName: "xmark.octagon")
    static let headerImage = UIImage(named: "Header")
    static let perfilAreaImage = UIImage(named: "PerfilArea")
    
    //MARK: - Icons
    static let defaultSoundIcon = UIImage(systemName: "speaker.fill")
    static let waitingSoundIcon = UIImage(systemName: "speaker.zzz.fill")
    static let playingSoundIcon = UIImage(systemName: "speaker.wave.3.fill")
    static let defaultMicIcon = UIImage(systemName: "mic.fill")
}
