//
//  TeamAnalysisList.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/18/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct TeamAnalysisList {
	var teams: [ScoutingTeam]
	var matches: [Match]
	
	
	private func getTeamIndexByNumber(_ lteams: [ScoutingTeam], number: Int) -> Int {
		let index = lteams.firstIndex(where: {$0.teamNum == number})!
		return index
	}
	
	func getProjected() -> [ScoutingTeam] {
		var localTeams = self.teams
		var rankedTeams = [ScoutingTeam]()
		for match in matches {
			let results = match.getMatchResults(teams: localTeams)
			
			for team in match.redTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)
				var scteam = localTeams[index]

				if scteam.QP == nil {
					scteam.QP = 0
				}
				if results["result"] as! String == "Red" {
					scteam.QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					scteam.QP! += 1
				}
				
				if scteam.TBP == nil {
					scteam.TBP = 0
				}
				scteam.TBP! += results["blue"] as! Float
				
				rankedTeams.append(scteam)
			}
			for team in match.blueTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)
				var scteam = teams[index]
				
				if scteam.QP == nil {
					scteam.QP = 0
				}
				if results["result"] as! String == "Blue" {
					scteam.QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					scteam.QP! += 1
				}
				
				if scteam.TBP == nil {
					scteam.TBP = 0
				}
				scteam.TBP! += results["red"] as! Float
		
				rankedTeams.append(scteam)
			}
		}
		
		rankedTeams.sort(by: {$0.TBP! > $1.TBP!})
		rankedTeams.sort(by: {$0.QP! > $1.QP!})
		
		return rankedTeams
	}
	
	/*
	func getActual() -> [Int] {
		
	}
	*/
	/*
	func getAI()-> [Int] {
		
	}
	*/
}
