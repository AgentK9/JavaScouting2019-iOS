//
//  NewMatchViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/15/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class NewMatchViewController: UIViewController {
	//MARK: - Storyboard Outlets
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var Red1Label: UILabel!
	@IBOutlet var Red2Label: UILabel!
	@IBOutlet var Blue1Label: UILabel!
	@IBOutlet var Blue2Label: UILabel!
	//MARK: - Variable Initialization
	var matchPath: String!
	var teamPath: String!
	var matchNum: Int!
	var red1: ScoutingTeam?
	var red2: ScoutingTeam?
	var blue1: ScoutingTeam?
	var blue2: ScoutingTeam?
	var selected: String!
	var db: Firestore!
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navBar.topItem?.title = "New Match"
		
		db = Firestore.firestore()
		refreshLabels()
		
    }
	//MARK: - UI Refresh
	func refreshLabels() {
		if red1 != nil {
			Red1Label.text = "\(red1!.teamNum) - \(red1!.teamName!)"
		}
		else {
			Red1Label.text = "Add Team \\/"
		}
		if red2 != nil {
			Red2Label.text = "\(red2!.teamNum) - \(red2!.teamName!)"
		}
		else {
			Red2Label.text = "Add Team \\/"
		}
		if blue1 != nil {
			Blue1Label.text = "\(blue1!.teamNum) - \(blue1!.teamName!)"
		}
		else {
			Blue1Label.text = "Add Team \\/"
		}
		if blue2 != nil {
			Blue2Label.text = "\(blue2!.teamNum) - \(blue2!.teamName!)"
		}
		else {
			Blue2Label.text = "Add Team \\/"
		}
	}
	//MARK: - Button Action Outlets
	//MARK: 	- Red
	@IBAction func red1Button(_ sender: Any) {
		selected = "Red1"
		performSegue(withIdentifier: "selectTeam", sender: UIButton.self)
	}
	@IBAction func red2Button(_ sender: Any) {
		selected = "Red2"
		performSegue(withIdentifier: "selectTeam", sender: UIButton.self)
	}
	//MARK: 	- Blue
	@IBAction func blue1Button(_ sender: Any) {
		selected = "Blue1"
		performSegue(withIdentifier: "selectTeam", sender: UIButton.self)
	}
	@IBAction func blue2Button(_ sender: Any) {
		selected = "Blue2"
		performSegue(withIdentifier: "selectTeam", sender: UIButton.self)
	}
	//MARK: - Data
	func getListOfTeams(_ type: String) -> [ScoutingTeam?] {
		var list: [ScoutingTeam?] = [ScoutingTeam?]()
		switch type {
		case "red":
			list = [red1, red2]
		case "blue":
			list = [blue1, blue2]
		case "all":
			list = [red1, red2, blue1, blue2]
		default:
			print("unknown type")
		}
		return list
	}
	//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "selectTeam":
			let destination = segue.destination as! TeamSelectViewController
			destination.teamPath = self.teamPath
			destination.teamColNum = self.selected
			print("TeamColNum" + selected)
			destination.preTeams = getListOfTeams("all")
		case "doneMatch":
			let redTeams = getListOfTeams("red")
			let blueTeams = getListOfTeams("blue")
			let red = [redTeams[0]!.teamNum, redTeams[1]!.teamNum]
			let blue = [blueTeams[0]!.teamNum, blueTeams[1]!.teamNum]
			let docData: [String: Any] = [
				"matchNum": matchNum,
				"redTeams": red,
				"blueTeams": blue
			]
			db.collection(matchPath).document("\(matchNum!)").setData(docData)
			print("done with match")
		default:
			print("unrecognized segue identifier")
		}
    }
	@IBAction func unwindFromTeamSelect(segue: UIStoryboardSegue) {
		
	}

}
