//
//  ScoutingTeam.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct ScoutingTeam: Codable {
	var teamNum: Int
	var teamName: String?
	var record: String?
	var bestScore: Int?
	var latestScore: Int?
	var path: String
	var scouting: [ScoutingData]
	var compRecord: [Int]
	var QP: Int?
	var TBP: Float?
	var AIRank: Double?
	
	private func getListOf(type: String) -> [Int] {
		var list: [Int] = [Int]()
		
		if scouting.count > 1 {
			let newScouting = scouting.filter({$0.matchID > 0})
			for item in newScouting {
				switch type {
				case "auto":
					list.append(item.autoPts())
				case "tele":
					list.append(item.teleOpPts())
				case "end":
					list.append(item.endGamePts())
				case "total":
					list.append(item.totalPts())
				default:
					print("unknown type")
				}
			}
			for item in scouting {
				switch type {
				case "auto":
					list.append(item.autoPts())
				case "tele":
					list.append(item.teleOpPts())
				case "end":
					list.append(item.endGamePts())
				case "total":
					list.append(item.totalPts())
				default:
					print("unknown type")
				}
			}
		}
		else {
			for item in scouting {
				switch type {
				case "auto":
					list.append(item.autoPts())
				case "tele":
					list.append(item.teleOpPts())
				case "end":
					list.append(item.endGamePts())
				case "total":
					list.append(item.totalPts())
				default:
					print("unknown type")
				}
			}
		}
		return list
	}
	
	func avgScore(type: String) -> Float {
		let list: [Int] = getListOf(type: type)
		var total: Int = 0
		
		for item in list {
			total += item
		}
		
		var average: Float = Float(total)/Float(list.count)
		if average.isNaN {
			average = 0
		}
		return average
		
	}
	func totalScoreDev() -> Float {
		let avg = avgScore(type: "total")
		var totalDev: Float = 0
		for scout in scouting {
			var deviation = avg - Float(scout.totalPts())
			if deviation.isLess(than: 0) {
				deviation -= deviation * 2
			}
			totalDev += deviation
		}
		let stdDev = totalDev / Float(scouting.count)
		return stdDev
	}
	func highScore(type: String) -> Float {
		let list: [Int] = getListOf(type: type)
		var maximum = 0
		
		for item in list {
			if item > maximum {
				maximum = item
			}
		}
		
		return Float(maximum)
	}
	func lowScore(type: String) -> Float {
		let list: [Int] = getListOf(type: type)
		var minimum = 1500
		
		for item in list {
			if item < minimum {
				minimum = item
			}
		}
		
		return Float(minimum)
	}
}
