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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Teams"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = teams.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
		let team = teams[indexPath.row]
		cell.textLabel?.text = team.teamName
        return cell
    }
	
	@IBAction func unwindFromTeamDetail(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		//Auth.auth().removeStateDidChangeListener(handle!)
	}
	
}

