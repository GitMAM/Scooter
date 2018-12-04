//
//  OnBoardingVC.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 20/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit

class OnBoardingVC: UIViewController {
    
    let skipButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: Asset.hotels.image,
                           title: "Unlock",
                           description: "Find a scooter near you and scan to unlock",
                           pageIcon: Asset.key.image,
                           color: UIColor.firstRed,
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.banks.image,
                           title: "Safety",
                           description: "Bring your helmet to stay safe",
                           pageIcon: Asset.wallet.image,
                           color: UIColor.secondRed,
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.stores.image,
                           title: "Start your ride",
                           description: "Go ahead and start your ride",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor.thirdRed,
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.End.image,
                           title: "End your trip",
                           description: "End your ride by tapping the button within the app",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor.fourthRed,
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        OnboardingItemInfo(informationImage: Asset.parking.image,
                           title: "Park Scooter",
                           description: "Make sure to not block enterances or side walk and leave in visable place",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor.fifthRed,
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
            
            onboarding.addSubview(skipButton)
            skipButton.anchor(top: onboarding.topAnchor, left: nil, bottom: nil, right: onboarding.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 80, height: 30)

        }
    }
}

// MARK: Actions

extension OnBoardingVC {
    
    @objc func skipButtonTapped(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: PaperOnboardingDelegate

extension OnBoardingVC: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 4 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension OnBoardingVC: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return items.count
    }
}


//MARK: Constants
extension OnBoardingVC {
    
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
}

