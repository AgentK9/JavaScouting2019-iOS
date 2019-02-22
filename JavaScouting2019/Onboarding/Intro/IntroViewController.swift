//
//  IntroViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/22/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import paper_onboarding

class IntroViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {
    
    @IBOutlet var skipButton: UIButton!

    //Custom fonts
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    
    //Add the following items to the onboarding view (to be shown to the user).
    let onBoardItem: OnboardingItemInfo = OnboardingItemInfo(
        informationImage: UIImage(named: "intro-quiz")!,
        title: "Scout",
        description: "Our app can help you collect scout data during your FTC competition.  You can store all of your data and share it between your team members by logging in.",
        pageIcon: UIImage(named: "intro-quiz-bottom")!,
        color: UIColor.init(named: "PrimaryRed")!,
        titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
    
    let onBoardItem2: OnboardingItemInfo = OnboardingItemInfo(
        informationImage: UIImage(named: "intro-leaderboard")!,
        title: "AI",
        description: "We utilize AI to create rankings of teams.  We also use AI to generate the best alliance partners.",
        pageIcon: UIImage(named: "intro-leaderboard-bottom")!,
        color: UIColor.init(named: "PrimaryGrey")!,
        titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
    
    let onBoardItem3: OnboardingItemInfo = OnboardingItemInfo(informationImage: UIImage(named: "intro-book")!,
        title: "Competitions",
        description: "All your data is saved from competitions so you can go back and view scouting data at any time.",
        pageIcon: UIImage(named: "intro-book-bottom")!,
        color: UIColor.init(named: "PrimaryBlue")!,
        titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    func setupPaperOnboardingView() {
        //Do the stup for the view.
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        //Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(
                item: onboarding,
                attribute: attribute,
                relatedBy: .equal,
                toItem: view,
                attribute: attribute,
                multiplier: 1,
                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    @IBAction func skipButtonAction(_: UIButton) {
        //Handle if the user is signed in (bring them home and save that they have finished the onboarding) or if they need to sign in.
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        if Auth.auth().currentUser != nil {
            UserDefaults.standard.set(true, forKey: "oboarding-shown-\(version)")
            //go to home
        }else{
            UserDefaults.standard.set(true, forKey: "oboarding-shown-\(version)")
            //go to the login view
        }
    }
    
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [onBoardItem, onBoardItem2, onBoardItem3][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }

}
