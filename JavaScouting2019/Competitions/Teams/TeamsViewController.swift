//
//  FirstViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/20/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

import FirebaseAuth

class TeamsViewController: UITableViewController {
	
	var teams: [ScoutingTeam]!
	var path: String = ""
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		}
	
    override func viewDidLoad() {
		print(path)
        super.viewDidLoad()
        
        self.title = "Teams"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = teams.count
		print(count)
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
		let team = teams[indexPath.row]
		cell.textLabel?.text = team.teamName
		cell.detailTextLabel?.text = "\(team.teamNum)"
        return cell
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "teamCellToDetail":
			let destination = segue.destination as! TeamDetailViewController
			let indexPath = self.tableView.indexPathForSelectedRow!
			
			destination.selectedTeam = teams[indexPath.row]
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
	
	override func viewWillDisappear(_ animated: Bool) {
		//Auth.auth().removeStateDidChangeListener(handle!)
	}
	
}

