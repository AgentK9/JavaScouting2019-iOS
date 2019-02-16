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
	var scouting: [ScoutingData]?
	
	private func getListOf(type: String) -> [Int] {
		var list: [Int] = [Int]()
		
		if scouting != nil {
			for item in scouting! {
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
		
		let average: Float = Float(total)/Float(list.count)
		return average
		
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
