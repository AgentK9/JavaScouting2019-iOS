//
//  LoginViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/14/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardObservers()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if (!self.fieldsAreFilled()) {
            //the user needs to fill the fields in
            return
        }
        
        guard let email = self.emailTextField.text, let password = self.passTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                //send user to the home page (login succeeded)
            }else{
                //and error has occurred while logging in
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
        // Add gesture recognizer to handle tapping outside of keyboard
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardTap)
    }

}
