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
	var comp: Competition = Competition(compID: nil, compname: "", path: "", teams: nil)
	var path = "test-competitions/"
	
	override func viewDidLoad() {
        super.viewDidLoad()
		db = Firestore.firestore()
		
		navBar.topItem?.title = "Add New Competition"

    }

	@IBAction func onGoButtonPress(_ sender: Any) {
		var ref: DocumentReference!
		ref = db.collection("/test-competitions/").addDocument(data: [
			"compname": nameTextField.text as Any,
			"path": "/test-competitions/"
		]) { err in
			if let err = err {
				print("Error adding document: \(err)")
			} else {
				print("Document added with ID: \(ref!.documentID)")
				self.comp.compID = ref!.documentID
				self.comp.compname = self.nameTextField.text!
			}
		}
		path += ref!.documentID + "/"
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		
		switch identifier {
		case "newCompToDetail":
			let tab = segue.destination as! UITabBarController
			let vcs = tab.viewControllers!
			
			let nav1 = vcs[0] as! UINavigationController
			let destination1 = nav1.viewControllers.first as! TeamsViewController
			//destination1.matchPath = comp.path + "matches/"
			destination1.path = comp.path + "teams/"
			
			let nav2 = vcs[1] as! UINavigationController
			let destination2 = nav2.viewControllers.first as! MatchTableViewController
			destination2.matchPath = comp.path + "matches/"
			destination2.teamPath = comp.path + "teams/"
			
			let nav3 = vcs[2] as! UINavigationController
			let destination3 = nav3.viewControllers.first as! AnalysisViewController
			destination3.matchPath = comp.path + "matches/"
			destination3.teamPath = comp.path + "teams/"
		default:
			print("unknown segue identifier")
		}
    }

}
