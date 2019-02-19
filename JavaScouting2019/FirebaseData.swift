//
//  FirebaseData.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/15/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation
import Firebase

class FirebaseData {
	var competitions: [Competition] = [Competition]()
	let grabber = FirebaseGrab()
	let path = "test-competitions/"
	var db: Firestore!
	init() {
		refresh()
	}
	func refresh() {
		if db != nil {
			getCompetitions()
			getTeams()
			//getScouts()
		}
		else {
			print("database not initialized. Initializing.")
			db = Firestore.firestore()
			getCompetitions()
		}
		
	}
	func getCompetitions() {
		grabber.dlCompetitions(db: db, path: path) {competitionArray, error in
			if let error = error {
				print("\(error)")
				return
			}
			self.competitions = competitionArray
			self.getTeams()
		}
	}
	func getTeams() {
		var i = 0
		for comp in competitions {
			let pathA = path + comp.compID! + "/teams/"
			let j = i
			grabber.dlTeams(db: db, path: pathA) { teamArray, error in
				if let error = error {
					print("\(error)")
					return
				}
				self.competitions[j].teams = teamArray
				if i == self.competitions.count - 1 {
					//self.getScouts()
				}
				print("comps are: \(self.competitions)")
			}
			i += 1
		}
	}
	/*
	func getScouts() {
		var i = 0
		for comp in competitions {
			var j = 0
			let pathA = path + comp.compID! + "/teams/"
			for team in comp.teams! {
				let pathB = pathA + "\(team.teamNum)/scoutData/"
				grabber.dlScouts(db: db, path: pathB) { scoutArray, error in
					if let error = error {
						print("\(error)")
						return
					}
					self.competitions[i].teams![j].scouting = scoutArray
				}
				j += 1
			}
			i += 1
		}
	}*/
}
