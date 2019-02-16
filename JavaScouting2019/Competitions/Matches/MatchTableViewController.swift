//
//  SecondViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/20/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class MatchTableViewController: UITableViewController {
	//MARK: - Variable Initialization
	var matchPath: String!
	var teamPath: String!
	var db: Firestore!
	let grabber = FirebaseGrab()
	var matches: [Match] = [Match]()
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Matches"
		refresh()
    }
	//MARK: - Data
	func refresh() {
		if db != nil {
			getMatches()
		}
		else {
			print("Database not initialized. Initializing.")
			db = Firestore.firestore()
			getMatches()
		}
	}
	func getMatches() {
		grabber.dlMatches(db: db, path: matchPath) { matchArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.matches = matchArray
			self.tableView.reloadData()
		}
	}
	//MARK: - TableView Datasource/Delegate
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = matches.count
		return count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath)
		let match = matches[indexPath.row]
		cell.detailTextLabel?.text = "\(match.matchNum)"
		let teamText = "\(match.redTeams[0]), \(match.redTeams[1]) - \(match.blueTeams[0]), \(match.blueTeams[1])"
		cell.textLabel?.text = teamText
		return cell
	}
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "newMatchSegue":
			let destination = segue.destination as! NewMatchViewController
			destination.matchPath = self.matchPath
			destination.teamPath = self.teamPath
			destination.matchNum = self.tableView.numberOfRows(inSection: 0) + 1
		default:
			print("unknown segue identifier")
		}
	}
	@IBAction func unwindFromNewMatch(segue: UIStoryboardSegue)  {
		
	}


}

