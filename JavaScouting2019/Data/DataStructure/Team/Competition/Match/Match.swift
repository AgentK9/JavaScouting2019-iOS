//
//  Match.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct Match: Codable {
	var matchNum: Int
	var redTeams: [Int]
	var blueTeams: [Int]
	
	func teams() -> [Int] {
		let array = redTeams + blueTeams
		return array
	}
	func getAuto(color: String, teams: [ScoutingTeam]?) -> Float {
		var score: Float = 0
		if teams != nil {
			switch color {
			case "red":
				for num in redTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "auto"))
					
				}
			case "blue":
				for num in blueTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "auto"))
					
				}
			default:
				print()
			}
		}
		return score
	}
	func getTeleOP(color: String, teams: [ScoutingTeam]?) -> Float {
		var score: Float = 0
		if teams != nil {
			switch color {
			case "red":
				for num in redTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "tele"))
					
				}
			case "blue":
				for num in blueTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "tele"))
					
				}
			default:
				print()
			}
		}
		return score
	}
	func getEndGame(color: String, teams: [ScoutingTeam]?) -> Float {
		var score: Float = 0
		if teams != nil {
			switch color {
			case "red":
				for num in redTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "end"))
					
				}
			case "blue":
				for num in blueTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					score += Float(team!.avgScore(type: "end"))
					
				}
			default:
				print()
			}
		}
		return score
	}
	func getScore(color: String, teams: [ScoutingTeam]?, type: String?) -> Float {
		var score: Float = 0
		if teams != nil {
			switch color {
			case "red":
				for num in redTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					if type == "actual" {
						if let matchScore = team?.scouting.first(where: {$0.matchID == self.matchNum}) {
							score += Float(matchScore.totalPts())
						}
						else {
							score -= 1000
						}
					}
					else {
						score += team?.avgScore(type: "total") ?? 0
					}
					if score == 0 {
						print("could not find data on team \(num)")
					}
				}
			case "blue":
				for num in blueTeams {
					let team = teams!.first(where: {$0.teamNum == num})
					if type == "actual" {
						if let matchScore = team?.scouting.first(where: {$0.matchID == self.matchNum}) {
							score += Float(matchScore.totalPts())
						}
						else {
							score -= 1000
						}
					}
					else {
						score += team?.avgScore(type: "total") ?? 0
					}
					if score == 0 {
						print("could not find data on team \(num)")
					}
				}
			default:
				print("unknown alliance color")
			}
		}
		return score
	}
	
	func getWinner(teams: [ScoutingTeam]?) -> String {
		var result: String = ""
		if teams != nil {
			let redScore = getScore(color: "red", teams: teams, type: nil)
			let blueScore = getScore(color: "blue", teams: teams, type: nil)
			if blueScore > redScore {
				result = "Blue"
			}
			else if redScore > blueScore {
				result = "Red"
			}
			else {
				result = "Tie"
				print("Red scored \(redScore), while Blue scored \(blueScore)")
			}
		}
		return result
	}
	func getMatchResults(teams: [ScoutingTeam]?) -> [String: Any] {
		var results: [String: Any]!
		var result: String = ""
		var redScore: Float = 0
		var blueScore: Float = 0
		if teams != nil {
			redScore = getScore(color: "red", teams: teams, type: nil)
			blueScore = getScore(color: "blue", teams: teams, type: nil)
			result = getWinner(teams: teams)
		}
		results = [
			"red": redScore,
			"blue": blueScore,
			"result": result
		]
		return results
	}
	
	func getActualWinner(teams: [ScoutingTeam]?) -> String {
		var result: String = ""
		if teams != nil {
			let redScore = getScore(color: "red", teams: teams, type: "actual")
			let blueScore = getScore(color: "blue", teams: teams, type: "actual")
			if blueScore > redScore {
				result = "Blue"
			}
			else if redScore > blueScore {
				result = "Red"
			}
			else {
				result = "Tie"
				print("Red scored \(redScore), while Blue scored \(blueScore)")
			}
		}
		return result
	}
	func getActualMatchResults(teams: [ScoutingTeam]?) -> [String: Any] {
		var results: [String: Any]!
		var result: String = ""
		var redScore: Float = 0
		var blueScore: Float = 0
		if teams != nil {
			redScore = getScore(color: "red", teams: teams, type: "actual")
			blueScore = getScore(color: "blue", teams: teams, type: "actual")
			result = getActualWinner(teams: teams)
		}
		if redScore.isLess(than: 0.0) {
			result = "N"
		}
		if blueScore.isLess(than: 0.0) {
			result = "N"
		}
		results = [
			"red": redScore,
			"blue": blueScore,
			"result": result
		]
		return results
	}
}
