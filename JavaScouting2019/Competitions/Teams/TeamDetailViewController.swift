//
//  TeamDetailViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class TeamDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	//MARK: - Storyboard Outlets
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var recordLabel: UILabel!
	@IBOutlet var scoutingItemTable: UITableView!
	@IBOutlet var compRecordLabel: UILabel!
	@IBOutlet var autoLabel: UILabel!
	@IBOutlet var teleLabel: UILabel!
	@IBOutlet var endGameLabel: UILabel!
	@IBOutlet var totalLabel: UILabel!
	//MARK: - Variable Init
	var selectedTeam: ScoutingTeam?
	var db: Firestore!
	let grabber = FirebaseGrab()
	var path: String!
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		refreshLabels()
		//refresh()
		navBar.topItem?.title = "\(selectedTeam!.teamName!) - \(selectedTeam!.teamNum)"
		recordLabel.text = "Season Record: " + selectedTeam!.record!
		
        // Do any additional setup after loading the view.
		self.scoutingItemTable.delegate = self
		self.scoutingItemTable.dataSource = self
    }
	//MARK: - Data Retriever
	func refresh() {
		if db != nil {
		}
		else {
			print("database not initialized. initializing.")
			db = Firestore.firestore()
		}
	}
	func refreshLabels() {
		autoLabel.text = "\(selectedTeam!.highScore(type: "auto"))"
		teleLabel.text = "\(selectedTeam!.highScore(type: "tele"))"
		endGameLabel.text = "\(selectedTeam!.highScore(type: "end"))"
		totalLabel.text = "\(selectedTeam!.highScore(type: "total"))"
	}
	//MARK: - TableView Source
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = selectedTeam!.scouting.count
		return count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemScoutingCell", for: indexPath)
		let item = selectedTeam!.scouting[indexPath.row]
		cell.textLabel?.text = "\(item.totalPts())"
		if item.matchID < 0 {
			cell.detailTextLabel?.text = "Match \(item.matchID)"
		}
		else {
			cell.detailTextLabel?.text = "Initital"
		}
		return cell
	}
	//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "detailToNewScout":
			let destination = segue.destination as! InitScoutViewController
			
			destination.teamNum = self.selectedTeam?.teamNum
			destination.path = self.path
		case "unwindFromTeamDetail":
			let destination = segue.destination as! TeamsViewController
			
			destination.refresh()
		default:
			print("unknown segue identifier")
		}
    }
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingDone(segue: UIStoryboardSegue) {
		refresh()
	}
}
