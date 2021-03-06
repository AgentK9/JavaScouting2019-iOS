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
	//@IBOutlet var compRecordLabel: UILabel!
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
		
		refresh()
		refreshLabels()
		navBar.topItem?.title = "\(selectedTeam!.teamName!) - \(selectedTeam!.teamNum)"
		recordLabel.text = "Season Record: " + selectedTeam!.record!
		
        // Do any additional setup after loading the view.
		self.scoutingItemTable.delegate = self
		self.scoutingItemTable.dataSource = self
    }
	//MARK: - Data Retriever
	func refresh() {
		if db != nil {
			getTeam()
		}
		else {
			print("database not initialized. initializing.")
			db = Firestore.firestore()
			getTeam()
		}
	}
	func getTeam() {
		grabber.dlTeam(db: db, path: path) { team, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.selectedTeam! = team
			self.refreshLabels()
			self.scoutingItemTable.reloadData()
		}
	}
	func refreshLabels() {
		//compRecordLabel.text = "Competition Record: \(selectedTeam!.compRecord[0])-\(selectedTeam!.compRecord[1])-\(selectedTeam!.compRecord[2])"
		autoLabel.text = "Average Auto: \(selectedTeam!.highScore(type: "auto"))"
		teleLabel.text = "Average TeleOp: \(selectedTeam!.highScore(type: "tele"))"
		endGameLabel.text = "Average End Game: \(selectedTeam!.highScore(type: "end"))"
		totalLabel.text = "Average Total: \(selectedTeam!.highScore(type: "total"))"
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
		if item.matchID > 0 {
			cell.detailTextLabel?.text = "Match \(item.matchID)"
		}
		else {
			cell.detailTextLabel?.text = "Initial"
		}
		return cell
	}
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == .delete) {
			db.document(path + "\(selectedTeam!.scouting[indexPath.row].matchID)").delete()
			refresh()
		}
	}
	//MARK: - Storyboard Functions
	@IBAction func refreshButton(_ sender: Any) {
		refresh()
	}
	//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "detailToNewScout":
			let destination = segue.destination as! InitScoutViewController
			
			destination.teamNum = self.selectedTeam!.teamNum
			destination.path = self.path
		case "teamToScoutDetail":
			let destination = segue.destination as! ScoutViewController
			let index = self.scoutingItemTable.indexPathForSelectedRow
			let scoutingItem = self.selectedTeam!.scouting[index!.row]
			destination.editScout = true
			destination.outScout = scoutingItem
			if scoutingItem.matchID == 0 {
				destination.isInitial = true
			}
			else {
				destination.isInitial = false
			}
			destination.matchNum = scoutingItem.matchID
			destination.path = self.path.dropLast() + ".scouting.\(scoutingItem.matchID)"
			destination.teamNum = self.selectedTeam!.teamNum
		case "unwindFromTeamDetail":
			let destination = segue.destination as! TeamsViewController
			destination.refresh()
		default:
			print("unknown segue identifier")
		}
    }
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingDetail(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingDone(segue: UIStoryboardSegue) {
		refresh()
	}
}
