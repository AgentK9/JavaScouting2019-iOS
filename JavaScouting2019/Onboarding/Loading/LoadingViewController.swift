//
//  LoadingViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/21/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {

    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Detect if user is logged in and has completed the onboarding view. If they are signed in and have viewed the onboarding, bring them to the home. If they haven't viewed the onboarding, show it now. Also if they aren't signed in but have viewed the onboarding, bring them to the login.
        DispatchQueue.main.async(execute: { () -> Void in
            if UserDefaults.standard.bool(forKey: "oboarding-shown-\(self.version)") {
                if Auth.auth().currentUser != nil {
                    //Home
                    //go to the home view
                }else{
                    //Login
                    let vcController = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.present(vcController, animated: false, completion: nil)
                }
            }else{
                //Onboarding view
                //move to a cool Onboarding view that I will add in the future
            }
        })
    }

}
