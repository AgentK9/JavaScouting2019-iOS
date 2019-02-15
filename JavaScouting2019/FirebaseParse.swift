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
	func compParse(_ compDoc: DocumentSnapshot, db: Firestore) -> Competition {
		let compData = compDoc.data()
		var comp: Competition!
		if let newComp = try? JSONSerialization.data(withJSONObject: compData, options: []) {
			var teamsDone: Bool = false
			comp = try! JSONDecoder().decode(Competition.self, from: newComp)
			comp.compID = compDoc.documentID
			if comp.matches == nil {
				comp.matches = [Match]()
			}
		}
		return comp
	}
	func teamsParse(_ teamDoc: DocumentSnapshot, db: Firestore) -> ScoutingTeam {
		let teamData = teamDoc.data()
		var team: ScoutingTeam!

		if let newTeam = try? JSONSerialization.data(withJSONObject: teamData, options: []) {
			team = try! JSONDecoder().decode(ScoutingTeam.self, from: newTeam)
		}
		print("got teams")
		return team
	}
}
