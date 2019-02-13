//
//  Competition.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct Competition: Codable {
	var compID: String?
	var compname: String
	var teams: [ScoutingTeam]?
	var matches: [Match]?
}
