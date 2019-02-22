//
//  AnalysisViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/18/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class AnalysisViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	//MARK: - Storyboard Outlets
	@IBOutlet var tableView: UITableView!
	@IBOutlet var typeOfRank: UISegmentedControl!
	//MARK: - Variable Initialization
	var teamPath: String!
	var matchPath: String!
	var teams: [ScoutingTeam]!
	var matches: [Match]!
	let grabber = FirebaseGrab()
	var db: Firestore!
	var matchAnalysis: TeamAnalysisList!
	var tableTeams: [ScoutingTeam] = [ScoutingTeam]()
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Analysis"

        // Do any additional setup after loading the view.
		refresh()
		self.tableView.delegate = self
		self.tableView.dataSource = self
    }
	// MARK: - Data
	func refresh() {
		if db != nil {
			getTeams()
			getMatches()
		}
		else {
			print("database not initialized. Initializing.")
			db = Firestore.firestore()
			getTeams()
			getMatches()
		}
	}
	func getTeams() {
		grabber.dlTeams(db: db, path: teamPath) { teamArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			
			self.teams = teamArray
			self.refreshSorting()
		}
	}
	func getMatches() {
		grabber.dlMatches(db: db, path: matchPath) { matchArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			
			self.matches = matchArray
			self.refreshSorting()
		}
	}
	func refreshSorting() {
		tableTeams = [ScoutingTeam]()
		if teams != nil && matches != nil {
			matchAnalysis = TeamAnalysisList(teams: teams, matches: matches)
			switch typeOfRank.selectedSegmentIndex {
			case 1:
				tableTeams = matchAnalysis.getActual()
			case 2:
				print("yeet")
			default:
				tableTeams = matchAnalysis.getProjected()
			}
			tableView.reloadData()
		}
	}
	//MARK: - Storyboard functions
	@IBAction func onRankTypeChange(_ sender: Any) {
		refreshSorting()
	}
	@IBAction func refreshButton(_ sender: Any) {
		refresh()
	}
	//MARK: - TableView Datasource/Delegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = tableTeams.count
		return count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "rankedTeamCell", for: indexPath)
		let team = tableTeams[indexPath.row]
		cell.textLabel?.text = "\(team.teamName!) - \(team.teamNum)"
		cell.detailTextLabel?.text = "QP: \(team.QP!), TBP: \(team.TBP!)"
		return cell
	}
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
