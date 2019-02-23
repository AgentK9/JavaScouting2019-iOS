//
//  SignupViewController.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/21/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, AlertController {

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
            presentSimpleAlert(title: "Field error", message: "Please make sure to fill out all the fields.", completion: nil)
            return
        }
        
        if (self.profileSettingsAreAdequate()) {
            Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                if let error = error {
                    self.presentSimpleAlert(title: "Error", message: "We ran into an error while creating your new account.  \(error.localizedDescription)", completion: nil)
                    return
                }
                self.db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
                    "name": self.firstLastField.text,
                    "teamNumber": (self.teamNumberField.text ?? "")
                ]) { err in
                    if let err = err {
                        self.presentSimpleAlert(title: "Error", message: "We ran into an error while saving your data to our server.  \(err.localizedDescription)", completion: nil)
                    } else {
                        //TODO: Send user to the home view
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
                presentSimpleAlert(title: "Field error", message: "Please make sure that you have not used any illegal characters in the fields.", completion: nil)
                return false
            }
        }
        
        if (password.count < 6) {
            presentSimpleAlert(title: "Field error", message: "Please make sure to enter a password that has at least 6 characters.", completion: nil)
            return false
        }
        
        return true
    }
    
}
