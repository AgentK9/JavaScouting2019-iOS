//
//  Path.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/16/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

class Path {
	var root: String = "test-competitions"
	var comp: String?
	var matches: Bool?
	var match: String?
	var teams: Bool?
	var team: Int?
	var scouting: Int?
	
	func getCurrentPath() -> String {
		var path: String = ""
		path += root
		path += "/"
		if comp != nil {
			path += comp!
			path += "/"
			if matches != nil {
				path += "matches"
				path += "/"
				if match != nil {
					path += match!
					path += "/"
				}
			}
			else if teams != nil {
				path += "teams"
				path += "/"
				if team != nil {
					path += String(team!)
					path += "/"
					if scouting != nil {
						path += "scoutData"
						path += "/"
						path += String(scouting!)
						path += "/"
					}
				}
			}
		}
		return path
	}
	func getPathToComp() -> String {
		var path: String = ""
		path += root
		path += "/"
		if comp != nil {
			path += comp!
			path += "/"
		}
		return path
	}
	
}
