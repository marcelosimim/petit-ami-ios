//
//  Carousel.swift
//  PetitAmi
//
//  Created by Marcelo Simim on 01/03/22.
//

import Foundation
import UIKit

@objc public protocol CarouselDelegate: AnyObject {
    func carouselDidScroll()
}

final public class Carousel: UIView, UICollectionViewDelegateFlowLayout{
    
    public var delegate: CarouselDelegate?
    //private let topTenViewModel: BreweryTopTenViewModel = BreweryContainer.shared.resolve(BreweryTopTenViewModel.self)!
    public var slides: [CarouselSlide] = [] {
        didSet {
            updateUI()
        }
    }
    
    public var currentlyVisibleIndex: Int? {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        return collectionView.indexPathForItem(at: visiblePoint)?.item
    }
    
    public lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.hidesForSinglePage = true
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        cv.clipsToBounds = true
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [collectionView, pageControl])
        stack.axis = .vertical
        //stack.layer.cornerRadius = 20
        stack.spacing = 5
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
//        topTenViewModel.fetchTopTen()
//        topTenViewModel.onShowTopTen = {
//            self.updateUI()
//        }
        updateUI()
        setupCarousel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        topTenViewModel.fetchTopTen()
//        topTenViewModel.onShowTopTen = {
//            self.updateUI()
//        }
        updateUI()
        setupCarousel()
    }
    
    // MARK: - Configuration Methods
    private func setupCarousel() {
        //contentStack.backgroundColor = .red
        //collectionView.backgroundColor = .blue
//        pageControl.backgroundColor = .yellow
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        print(screenHeight)
        
        addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.heightAnchor.constraint(equalToConstant: (260/640)*screenHeight),
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentStack.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            collectionView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.9),
            
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            pageControl.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            pageControl.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = self.slides.count
            self.pageControl.size(forNumberOfPages: self.slides.count)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension Carousel: UICollectionViewDelegate{
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: - UICollectionViewDataSource

extension Carousel: UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        //return topTenViewModel.breweryTopTen.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as? CarouselCell
        else { return CarouselCell() }
        
        //let path = self.topTenViewModel.breweryTopTen[indexPath.row]
        
        cell.imageArea.image = UIImage(named: "Logo")!
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension Carousel {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let index = currentlyVisibleIndex {
            pageControl.currentPage = index
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.carouselDidScroll()
    }
}
