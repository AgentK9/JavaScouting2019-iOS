//
//  FirebaseGrab.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/14/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation
import Firebase

class FirebaseParse {
	func compParse(_ compDoc: DocumentSnapshot) -> Competition {
		let compData = compDoc.data()
		var comp: Competition!
		if let newComp = try? JSONSerialization.data(withJSONObject: compData, options: []) {
			var teamsDone: Bool = false
			comp = try! JSONDecoder().decode(Competition.self, from: newComp)
			comp.compID = compDoc.documentID
		}
		return comp
	}
	func teamsParse(_ teamDoc: DocumentSnapshot) -> ScoutingTeam {
		let teamData = teamDoc.data()
		var team: ScoutingTeam!

		if let newTeam = try? JSONSerialization.data(withJSONObject: teamData, options: []) {
			team = try! JSONDecoder().decode(ScoutingTeam.self, from: newTeam)
		}
		print("got team")
		return team
	}
	func scoutParse(_ scoutDoc: DocumentSnapshot) -> ScoutingData {
		let scoutData = scoutDoc.data()
		var scout: ScoutingData!
		
		if let newScout = try? JSONSerialization.data(withJSONObject: scoutData, options: []) {
			scout = try! JSONDecoder().decode(ScoutingData.self, from: newScout)
		}
		return scout
	}
}
