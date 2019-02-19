//
//  FirstViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/20/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TeamsViewController: UITableViewController {
	//MARK: - Variable Initialization
	var teams: [ScoutingTeam] = [ScoutingTeam]()
	var path: String = ""
	let grabber = FirebaseGrab()
	var db: Firestore!
	//MARK: - View handlers
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Teams"
		refresh()
    }
	override func viewWillDisappear(_ animated: Bool) {
		//Auth.auth().removeStateDidChangeListener(handle!)
	}
	//MARK: - Data
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
		grabber.dlTeams(db: db, path: path) {teamArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.teams = teamArray
			self.tableView.reloadData()
		}
	}
	//MARK: - TableView Datasource/Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = teams.count
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
		let team = teams[indexPath.row]
		cell.textLabel?.text = team.teamName
		cell.detailTextLabel?.text = "\(team.teamNum)"
        return cell
    }
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "teamCellToDetail":
			let destination = segue.destination as! TeamDetailViewController
			let indexPath = self.tableView.indexPathForSelectedRow!
			let team = teams[indexPath.row]
			destination.selectedTeam = team
			destination.path = self.path + "\(team.teamNum)/"
		case "teamsToNew":
			let destination = segue.destination as! NewTeamViewController
			
			destination.path = self.path
		default:
			print("unknown segue identifier")
		}
	}
	@IBAction func unwindFromTeamInit(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromTeamDetail(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}
	
	
	
}

