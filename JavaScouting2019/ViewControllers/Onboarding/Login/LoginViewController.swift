//
//  LoginViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/14/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, AlertController {

	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardObservers()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if (!self.fieldsAreFilled()) {
            presentSimpleAlert(title: "Field error", message: "Please make sure to fill out all the fields.", completion: nil)
            return
        }
        
        guard let email = self.emailTextField.text, let password = self.passTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                //TODO: Send the user to the home page
            }else{
                self.presentSimpleAlert(title: "Error", message: "We ran into an error while logging you into your account.  \(error!.localizedDescription)", completion: nil)
            }
        }
        
    }
    
    private func fieldsAreFilled() -> Bool {
        return self.emailTextField.text != "" && self.emailTextField.text != ""
    }
    
    @objc func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    private func addKeyboardObservers() {
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardTap)
    }

}
