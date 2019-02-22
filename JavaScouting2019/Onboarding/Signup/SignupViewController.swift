//
//  SignupViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/21/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var firstLastField: UITextField!
    @IBOutlet weak var teamNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObservers()
    }
    
    @IBAction func signupAction(_ sender: Any) {
    
        if (!self.fieldsAreFilled()) {
            //alert user to fill all the fields
            return
        }
        
        if (self.profileSettingsAreAdequate()) {
            Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                if let error = error {
                    //error creating the account
                    return
                }
                self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
                    "name": self.firstLastField.text,
                    "teamNumber": (self.teamNumberField.text ?? "")
                ]) { err in
                    if let err = err {
                        //error occurred while saving user data
                    } else {
                        //send user to the correct view after user creation was successful
                    }
                }
            }
        )}
        
    }
    
    @objc func dismissKeyboard() {
        firstLastField.resignFirstResponder()
        teamNumberField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    private func addKeyboardObservers() {
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func fieldsAreFilled() -> Bool {
        return self.firstLastField.text != "" && self.emailField.text != "" && self.passwordField.text != ""
    }
    
    
    private func profileSettingsAreAdequate() -> Bool {
        guard let name = firstLastField.text,
            let password = passwordField.text else { return false }
        
        for field in [name] {
            
            if (field.contains(".") || field.contains("$") || field.contains("#") ||
                field.contains("[") || field.contains("]") || field.contains("/") || field.contains(" ")) {
                //alert user they have used illegal characters
                return false
            }
        }
        
        if (password.count < 6) {
            //alert user to use a stronger password
            return false
        }
        
        return true
    }
    
}
