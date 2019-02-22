//
//  TeamSelectViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/16/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class TeamSelectViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	//MARK: - Storyboard Outlets
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var teamPicker: UIPickerView!
	//MARK: - variable init
	var teamColNum: String!
	var teamPath: String!
	var db: Firestore!
	let grabber: FirebaseGrab = FirebaseGrab()
	var teams: [ScoutingTeam] = [ScoutingTeam]()
	var preTeams: [ScoutingTeam?]!
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		switch teamColNum {
		case "Red1":
			self.navBar.topItem?.title = "Add Red A"
		case "Red2":
			self.navBar.topItem?.title = "Add Red B"
		case "Blue1":
			self.navBar.topItem?.title = "Add Blue A"
		case "Blue2":
			self.navBar.topItem?.title = "Add Blue B"
		default:
			self.navBar.topItem?.title = "unknown teamColNum"
		}
		self.teamPicker.delegate = self
		self.teamPicker.dataSource = self
		refresh()
		
    }
	//MARK: - Data refresh/pull
	func refresh() {
		if db != nil {
			getTeams()
		}
		else {
			print("database not initialized. Initializing.")
			db = Firestore.firestore()
			getTeams()
		}
	}
	func getTeams() {
		grabber.dlTeams(db: db, path: teamPath) {teamArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.teams = teamArray
			for preTeam in self.preTeams {
				self.teams.removeAll(where: {$0.teamNum == preTeam?.teamNum})
			}
			self.teamPicker.reloadComponent(0)
		}
	}
	//MARK: - pickerview datasource/delegate
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		let count = teams.count
		return count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let team = teams[row]
		let teamAttrs = "\(team.teamNum) - " + team.teamName!
		return teamAttrs
	}
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "doneSelect":
			let destination = segue.destination as! NewMatchViewController
			let index = teamPicker.selectedRow(inComponent: 0)
			let team = teams[index]
			switch teamColNum {
			case "Red1":
				destination.red1 = team
			case "Red2":
				destination.red2 = team
			case "Blue1":
				destination.blue1 = team
			case "Blue2":
				destination.blue2 = team
			default:
				print("unknown teamColNum")
			}
			destination.refreshLabels()
		case "cancelSelect":
			print("canceled selection of team")
		default:
			print("unknown segue identifier")
		}
    }

}
