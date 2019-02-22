//
//  CompetitionTableViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/12/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class CompetitionTableViewController: UITableViewController {
	
	var competitions: [Competition] = [Competition]()
	var db: Firestore!
	let path: String = "/test-competitions/"
	let grabber = FirebaseGrab()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Competitions"
		
		refresh()
	}
	
	func refresh() {
		if db != nil {
			getCompetitions()
		}
		else {
			print("Database not initialized. Initializing.")
			db = Firestore.firestore()
			getCompetitions()
		}
	}
	func getCompetitions() {
		grabber.dlCompetitions(db: db, path: path) { competitionArray, error in
			if let error = error {
				return
			}
			self.competitions = competitionArray
			self.tableView.reloadData()
		}
	}

	@IBAction func refreshButton(_ sender: Any) {
		refresh()
	}
	
    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = competitions.count
		return count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell", for: indexPath)
		let comp = competitions[indexPath.row]
		
		cell.textLabel?.text = comp.compname

        return cell
    }
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "existingCompetitionToDetail":
			let tab = segue.destination as! UITabBarController
			let vcs = tab.viewControllers!
			
			let nav1 = vcs[0] as! UINavigationController
			let destination1 = nav1.viewControllers.first as! TeamsViewController
			let indexPath = tableView.indexPathForSelectedRow
			let comp = self.competitions[indexPath!.row]
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
	
	@IBAction func unwindFromCompDetail(segue: UIStoryboardSegue) {
		refresh()
	}
	@IBAction func unwindFromCompAdd(segue: UIStoryboardSegue) {
	}
}
