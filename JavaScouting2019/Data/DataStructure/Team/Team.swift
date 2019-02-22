//
//  Team.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/11/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

struct Team: Codable {
	var number: Int
	var name: String
	var members: [Member]
	var competitions: [Competition]
}
