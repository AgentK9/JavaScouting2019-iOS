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
	var scouting: [ScoutingData] = [ScoutingData]()
	var db: Firestore!
	let grabber = FirebaseGrab()
	var path: String!
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		refreshLabels()
		refresh()
		navBar.topItem?.title = "\(selectedTeam!.teamName!) - \(selectedTeam!.teamNum)"
		recordLabel.text = "Season Record: " + selectedTeam!.record!
		
        // Do any additional setup after loading the view.
		self.scoutingItemTable.delegate = self
		self.scoutingItemTable.dataSource = self
    }
	//MARK: - Data Retriever
	func refresh() {
		if db != nil {
			getScouting()
		}
		else {
			print("database not initialized. initializing.")
			db = Firestore.firestore()
			getScouting()
		}
	}
	func refreshLabels() {
		autoLabel.text = "\(selectedTeam!.highScore(type: "auto"))"
		teleLabel.text = "\(selectedTeam!.highScore(type: "tele"))"
		endGameLabel.text = "\(selectedTeam!.highScore(type: "end"))"
		totalLabel.text = "\(selectedTeam!.highScore(type: "total"))"
	}
	func getScouting() {
		let pathA = path + "scoutData/"
		print(pathA)
		grabber.dlScouts(db: db, path: pathA) {scoutArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.scouting = scoutArray
			self.selectedTeam?.scouting = [ScoutingData]()
			self.selectedTeam!.scouting = self.scouting
			self.scoutingItemTable.reloadData()
			self.refreshLabels()
		}
	}
	//MARK: - TableView Source
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = scouting.count
		return count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemScoutingCell", for: indexPath)
		cell.textLabel?.text = "\(scouting[indexPath.row].claim)"
		return cell
	}
	//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "detailToNewScout":
			let destination = segue.destination as! InitScoutViewController
			
			destination.teamNum = self.selectedTeam?.teamNum
			
		default:
			print("unknown segue identifier")
		}
    }
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}

}
