//
//  MatchDetailViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/17/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class MatchDetailViewController: UIViewController {

	@IBOutlet var redTeamA: UILabel!
	@IBOutlet var redTeamB: UILabel!
	@IBOutlet var redAuto: UILabel!
	@IBOutlet var redTele: UILabel!
	@IBOutlet var redEnd: UILabel!
	@IBOutlet var redTotal: UILabel!
	
	@IBOutlet var blueTeamA: UILabel!
	@IBOutlet var blueTeamB: UILabel!
	@IBOutlet var blueAuto: UILabel!
	@IBOutlet var blueTele: UILabel!
	@IBOutlet var blueEnd: UILabel!
	@IBOutlet var blueTotal: UILabel!
	
	@IBOutlet var winLabel: UILabel!
	
	var selectedMatch: Match!
	let grabber = FirebaseGrab()
	var teams: [ScoutingTeam]!
	var matchTeams: [ScoutingTeam] = [ScoutingTeam]()
	var db: Firestore!
	var teamPath: String!
	var matchPath: String!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Match \(selectedMatch.matchNum)"
		refresh()
    }
	
	func refresh() {
		if db != nil {
			getTeams()
		}
		else {
			print("Database not initialized. Initializing.")
			db = Firestore.firestore()
			getTeams()
			
		}
	}
	private func getTeams() {
		grabber.dlTeams(db: db, path: teamPath) { teamArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.teams = teamArray
			self.refreshTeams()
			self.refreshLabels()
		}
	}
	private func refreshTeams() {
		if matchTeams.count == 0 {
			matchTeams.append(teams.first(where: {$0.teamNum == selectedMatch.redTeams[0]})!)
			matchTeams.append(teams.first(where: {$0.teamNum == selectedMatch.redTeams[1]})!)
			matchTeams.append(teams.first(where: {$0.teamNum == selectedMatch.blueTeams[0]})!)
			matchTeams.append(teams.first(where: {$0.teamNum == selectedMatch.blueTeams[1]})!)
		}
		else if matchTeams.count == 4 {
			matchTeams[0] = teams.first(where: {$0.teamNum == selectedMatch.redTeams[0]})!
			matchTeams[1] = teams.first(where: {$0.teamNum == selectedMatch.redTeams[1]})!
			matchTeams[2] = teams.first(where: {$0.teamNum == selectedMatch.blueTeams[0]})!
			matchTeams[3] = teams.first(where: {$0.teamNum == selectedMatch.blueTeams[1]})!
		}
		print(matchTeams)
	}
	private func refreshLabels() {
		if matchTeams.count == 4 {
			redTeamA.text = "\(matchTeams[0].teamName!) - \(matchTeams[0].teamNum)"
			redTeamB.text = "\(matchTeams[1].teamName!) - \(matchTeams[1].teamNum)"
			redTotal.text = "\(selectedMatch.getScore(color: "red", teams: matchTeams, type: nil))"
			
			blueTeamA.text = "\(matchTeams[2].teamName!) - \(matchTeams[2].teamNum)"
			blueTeamB.text = "\(matchTeams[3].teamName!) - \(matchTeams[3].teamNum)"
			blueTotal.text = "\(selectedMatch.getScore(color: "blue", teams: matchTeams, type: nil))"
			
			winLabel.text = "Winner: \(selectedMatch.getWinner(teams: teams))"
			
		}
		else {
			redTeamA.text = "Red Team A"
			redTeamB.text = "Red Team B"
			redTotal.text = "Red Alliance Total"
			
			blueTeamA.text = "Blue Team A"
			blueTeamB.text = "Blue Team B"
			blueTotal.text = "Blue Alliance Total"
			
			winLabel.text = "Winner"
		}
	}

	@IBAction func refreshButton(_ sender: Any) {
		refresh()
	}
	// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
    }
	@IBAction func unwindFromNewMatch(segue: UIStoryboardSegue)  {
	}


}
