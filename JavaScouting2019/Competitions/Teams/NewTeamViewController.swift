//
//  NewTeamViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/12/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class NewTeamViewController: UIViewController {

	var toTeamNumber: Int!
	var toTeam: ScoutingTeam!
	let toa = TOAGrab()
	var db: Firestore!
	var path: String = ""
	
	@IBOutlet var teamNumberTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		db = Firestore.firestore()

		self.title = "Add New Team"
        // Do any additional setup after loading the view.
    }
	
	@IBAction func onGoButtonTap(_ sender: Any) {
		toTeamNumber = Int(teamNumberTextField.text ?? "0")!
		toTeam = toa.grabTeam(toTeamNumber) { data, error in
			guard let data = data else {
				print(error)
				return
			}
		}
		toTeam.record = toa.grabTeamWLT(toTeam.teamNum) { data, error in
			guard let data = data else {
				print(error)
				return
			}
		}
		
		db.document(path + "/\(toTeam.teamNum)").setData(toTeam.dictionary)
		
		
	}
	


	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "newToTeamDetail":
			let destination = segue.destination as! TeamDetailViewController
			destination.selectedTeam = self.toTeam
		default:
			print("unrecognized segue identifier")
		}
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
	

}
