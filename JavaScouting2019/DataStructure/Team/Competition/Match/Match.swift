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
	var redScore: Int?
	var blueScore: Int?
	var redTeams: [Int]
	var blueTeams: [Int]
}
