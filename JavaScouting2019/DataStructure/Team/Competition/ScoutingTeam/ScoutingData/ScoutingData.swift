//
//  ScoutingData.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct ScoutingData: Codable {
	var matchID: Int?
	var land: Bool
	var sample: Int
	var claim: Bool
	var park: Bool
	var depotMin: Int
	var landerMin: Int
	var endGame: Int
	
	func autoPts() -> Int {
		var total: Int = 0
		
		switch land {
		case true:
			total += 30
		default:
			total += 0
		}
		switch sample {
		case 0:
			total += 50
		case 1:
			total += 25
		case 3:
			total += 8
		default:
			total += 0
		}
		switch claim {
		case true:
			total += 15
		default:
			total += 0
		}
		switch park {
		case true:
			total += 10
		default:
			total += 0
		}
		
		return total
	}
	func teleOpPts() -> Int {
		var total: Int = 0
		
		total += depotMin * 2
		total += landerMin * 5
		
		return total
	}
	func endGamePts() -> Int {
		var total: Int = 0
		switch endGame {
		case 0:
			total += 50
		case 1:
			total += 25
		case 2:
			total += 15
		default:
			total += 0
		}
		return total
	}
	func totalPts() -> Int {
		var total: Int = 0
		total += autoPts()
		total += teleOpPts()
		total += endGamePts()
		return total
	}
}
