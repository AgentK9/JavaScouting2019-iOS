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
	var bestScore: Int?
	var latestScore: Int?
	var scouting: [ScoutingData]?
}
