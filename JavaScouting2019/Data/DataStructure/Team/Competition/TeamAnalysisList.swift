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
	
	
	private func getTeamIndexByNumber(_ lteams: [ScoutingTeam], number: Int) -> Int? {
		let index = lteams.firstIndex(where: {$0.teamNum == number})
		return index
	}
	
	func getProjected() -> [ScoutingTeam] {
		var localTeams = self.teams
		var rankedTeams = [ScoutingTeam]()
		for match in matches {
			let results = match.getMatchResults(teams: localTeams)
			var matchTeams = [ScoutingTeam]()
			
			for team in match.redTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!

				if localTeams[index].QP == nil {
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Red" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				
				if localTeams[index].TBP == nil {
					localTeams[index].TBP = 0
				}
				localTeams[index].TBP! += results["blue"] as! Float
				
				matchTeams.append(localTeams[index])
			}
			for team in match.blueTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					print("QP is nil")
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Blue" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				
				if localTeams[index].TBP == nil {
					localTeams[index].TBP = 0
				}
				localTeams[index].TBP! += results["red"] as! Float
		
				matchTeams.append(localTeams[index])
			}
			
			for team in matchTeams {
				if let index = getTeamIndexByNumber(rankedTeams, number: team.teamNum) {
					rankedTeams[index] = team
				}
				else {
					rankedTeams.append(team)
				}
			}
		}
		
		rankedTeams.sort(by: {$0.TBP! > $1.TBP!})
		rankedTeams.sort(by: {$0.QP! > $1.QP!})
		
		return rankedTeams
	}
	
	func getActual() -> [ScoutingTeam] {
		var localTeams = teams
		var rankedTeams = [ScoutingTeam]()
		
		for match in matches {
			
			let results = match.getActualMatchResults(teams: localTeams)
			var matchTeams = [ScoutingTeam]()
			
			for team in match.redTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Red" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				if results["result"] as! String != "N" {
					if localTeams[index].TBP == nil {
						localTeams[index].TBP = 0
					}
					localTeams[index].TBP! += results["blue"] as! Float
					
					matchTeams.append(localTeams[index])
				}
			}
			for team in match.blueTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					print("QP is nil")
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Blue" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				if results["result"] as! String != "N" {
					if localTeams[index].TBP == nil {
						localTeams[index].TBP = 0
					}
					localTeams[index].TBP! += results["blue"] as! Float
					
					matchTeams.append(localTeams[index])
				}
			}
			
			for team in matchTeams {
				if let index = getTeamIndexByNumber(rankedTeams, number: team.teamNum) {
					rankedTeams[index] = team
				}
				else {
					rankedTeams.append(team)
				}
			}
		}
		
		rankedTeams.sort(by: {$0.TBP! > $1.TBP!})
		rankedTeams.sort(by: {$0.QP! > $1.QP!})
		
		return rankedTeams
	}
	/*
	func getAI()-> [Int] {
		
	}
	*/
}
