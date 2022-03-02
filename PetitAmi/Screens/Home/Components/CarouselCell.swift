//
//  CarouselCell.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 01/03/22.
//

import UIKit

public class CarouselCell: UICollectionViewCell {
    
    static let identifier = "\(CarouselCell.self)"
    
    public var slide : CarouselSlide? {
        didSet {
            guard let slide = slide else {
                return
            }
            parseData(forSlide: slide)
        }
    }
    
    public lazy var imageArea : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Configuration Methods
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubview(imageArea)
        
        NSLayoutConstraint.activate([
            imageArea.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            imageArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageArea.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func parseData(forSlide slide: CarouselSlide) {
        imageArea.image = slide.image
    }
}
