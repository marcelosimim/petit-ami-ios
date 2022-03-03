//
//  Home.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 03/03/22.
//

import UIKit

class HomeView: UIView {

    override func layoutSubviews() {
        backgroundColor = K.backgroundColor
        addComponents()
        addConstraints()
    }
    
    lazy var headerArea: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.headerImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var perfilArea: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.perfilAreaImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var welcomeLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userInfoLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var keepStudingArea: UIView = {
        let view = UIView()
        view.layer.backgroundColor = K.areaColor?.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressTitle: UILabel = {
       let label = UILabel()
        label.text = "Progresso"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
       let progressView = UIProgressView()
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5
        progressView.progress = 0.0
        progressView.trackTintColor = K.progressBarTrack
        progressView.progressTintColor = K.progressBarProgress
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    let keepStudyingLabel: UILabel = {
        let label = UILabel()
         label.text = "Continue estudando"
         label.numberOfLines = 0
         label.textColor = UIColor.white
         label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let coverImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = K.notFoundedImage
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView  = {
       let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    lazy var unitArea: UIView = {
        let view = UIView()
        view.layer.backgroundColor = K.areaColor?.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
         label.text = "Unidades"
         label.textColor = UIColor.white
         label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
}

extension HomeView: ViewConfiguration {
    func addComponents() {
        addSubview(headerArea)
        addSubview(perfilArea)
        addSubview(welcomeLabel)
        addSubview(userInfoLabel)
        addSubview(keepStudingArea)
        addSubview(progressTitle)
        addSubview(progressBar)
        addSubview(coverImage)
        addSubview(activityIndicator)
        addSubview(keepStudyingLabel)
        addSubview(unitArea)
        addSubview(unitLabel)
        coverImage.isUserInteractionEnabled = true
    }
    
    func addConstraints() {
        let imageSize: CGFloat = K.viewWidthProportion*100
        let horizontalDistance: CGFloat = 20
        NSLayoutConstraint.activate([
            headerArea.topAnchor.constraint(equalTo: topAnchor),
            headerArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*200),
            perfilArea.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*60),
            perfilArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*24),
            perfilArea.heightAnchor.constraint(equalToConstant: imageSize),
            perfilArea.widthAnchor.constraint(equalToConstant: imageSize),
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: K.viewHeightProportion*80),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*138),
            userInfoLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: K.viewHeightProportion*10),
            userInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*138),
            keepStudingArea.topAnchor.constraint(equalTo: headerArea.bottomAnchor, constant: K.viewHeightProportion*32),
            keepStudingArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: K.viewWidthProportion*horizontalDistance),
            keepStudingArea.centerXAnchor.constraint(equalTo: centerXAnchor),
            keepStudingArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*280),
            progressTitle.topAnchor.constraint(equalTo: keepStudingArea.topAnchor, constant: 16*K.viewHeightProportion),
            progressTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46*K.viewWidthProportion),
            progressTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 12*K.viewHeightProportion),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46*K.viewWidthProportion),
            progressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 10*K.viewHeightProportion),
            coverImage.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 30*K.viewHeightProportion),
            coverImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130*K.viewWidthProportion),
            coverImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 150*K.viewHeightProportion),
            activityIndicator.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 90*K.viewHeightProportion),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130*K.viewWidthProportion),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            keepStudyingLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 10*K.viewHeightProportion),
            keepStudyingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
    
            unitArea.topAnchor.constraint(equalTo: keepStudingArea.bottomAnchor, constant: K.viewHeightProportion*32),
            unitArea.leadingAnchor.constraint(equalTo: keepStudingArea.leadingAnchor),
            unitArea.trailingAnchor.constraint(equalTo: keepStudingArea.trailingAnchor),
            unitArea.heightAnchor.constraint(equalToConstant: K.viewHeightProportion*230),
            unitLabel.topAnchor.constraint(equalTo: unitArea.topAnchor, constant: K.viewHeightProportion*16),
            unitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46*K.viewWidthProportion),
            unitLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
