//
//  ScoutingData.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct ScoutingData: Codable {
	var matchID: Int
	var land: Bool
	var sample: Int
	var claim: Bool
	var park: Int
	var depotMin: Int
	var landerMin: Int
	var endGame: Int
}
