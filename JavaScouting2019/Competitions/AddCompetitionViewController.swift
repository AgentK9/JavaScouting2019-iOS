//
//  AddCompetitionViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/12/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class AddCompetitionViewController: UIViewController {

	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var nameTextField: UITextField!
	var db: Firestore!
	var comp: Competition = Competition(compID: nil, compname: "", teams: [ScoutingTeam](), matches: nil)
	
	override func viewDidLoad() {
        super.viewDidLoad()
		db = Firestore.firestore()
		
		navBar.topItem?.title = "Add New Competition"

    }

	@IBAction func onGoButtonPress(_ sender: Any) {
		var ref: DocumentReference!
		ref = db.collection("test-competitions").addDocument(data: [
			"compname": nameTextField.text
		]) { err in
			if let err = err {
				print("Error adding document: \(err)")
			} else {
				print("Document added with ID: \(ref!.documentID)")
				self.comp.compID = ref!.documentID
				self.comp.compname = self.nameTextField.text!
			}
		}
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		
		switch identifier {
		case "newCompToDetail":
			let tab = segue.destination as! UITabBarController
			let nav = tab.viewControllers?.first as! UINavigationController
			let destination = nav.viewControllers.first as! TeamsViewController
			destination.teams = self.comp.teams
		default:
			print("unknown segue identifier")
		}
    }

}
