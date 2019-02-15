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
	let path: String = "test-competitions"
	let parser: FirebaseParse = FirebaseParse()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
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
		db.collection(path).getDocuments() { (querySnapshot, err) in
			if let err = err {
				print("Error getting documents: \(err)")
			} else {
				for document in querySnapshot!.documents {
					var comp = self.parser.compParse(document, db: self.db)
					comp.teams = [ScoutingTeam]()
					self.db.collection(self.path + "/\(document.documentID)/teams/").getDocuments() { (querySnapshot, err) in
						if let err = err {
							print("Error getting documents: \(err)")
						} else {
							for teamDoc in (querySnapshot?.documents)! {
								comp.teams!.append(self.parser.teamsParse(teamDoc, db: self.db))
								print("got competition")
							}
							self.competitions.append(comp)
						}
						print("got competitions")
						self.tableView.reloadData()
					}
					
				}
				
			}
			
		}
		
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
			let nav = tab.viewControllers?.first as! UINavigationController
			let destination = nav.viewControllers.first as! TeamsViewController
			let indexPath = tableView.indexPathForSelectedRow
			let comp = self.competitions[indexPath!.row]
			
			destination.teams = comp.teams
			destination.path = self.path + "/" + comp.compID! + "/teams"
		default:
			print("unknown segue identifier")
		}
    }
	
	@IBAction func unwindFromCompDetail(segue: UIStoryboardSegue) {
	}
    
}
