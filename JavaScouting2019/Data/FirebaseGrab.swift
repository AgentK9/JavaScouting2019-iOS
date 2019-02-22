//
//  FirebaseGrab.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/14/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation
import Firebase

class FirebaseGrab {
	
	let parser = FirebaseParse()
	var competitions: [Competition] = [Competition]()
	
	func dlCompetitions(db: Firestore, path: String, completion: @escaping ([Competition], Error?) -> Void) {
		var competitionArray = [Competition]()
		let query = db.collection(path)
		query.getDocuments() { snapshot, error in
			if let error = error {
				print("Error getting documents: \(error)")
				completion(competitionArray, error)
				return
			}
			print(snapshot!.documents.count)
			for doc in snapshot!.documents {
				print("getting teams for competition")
				var comp = self.parser.compParse(doc)
				let pathA = path + "\(doc.documentID)/"
				comp.path = pathA
				competitionArray.append(comp)
			}
			completion(competitionArray, nil)
		}
		
	}
	
	func dlMatches(db: Firestore, path: String, completion: @escaping ([Match], Error?) -> Void) {
		var matchArray = [Match]()
		let query = db.collection(path)
		query.getDocuments() { snapshot, error in
			if let error = error {
				print("Error downloading matches: \(error)")
				completion(matchArray, error)
				return
			}
			for doc in snapshot!.documents {
				let match = self.parser.matchesParse(doc)
				matchArray.append(match)
			}
			matchArray.sort(by: {$0.matchNum > $1.matchNum})
			completion(matchArray, nil)
			
		}
		
	}
	
	func dlTeams(db: Firestore, path: String, completion: @escaping ([ScoutingTeam], Error?) -> Void) {
		var teamArray = [ScoutingTeam]()
		let query = db.collection(path)
		query.getDocuments() { snapshot, error in
			if let error = error {
				print("Error downloading teams: \(error)")
				completion(teamArray, error)
				return
			}
			for doc in snapshot!.documents {
				var team = self.parser.teamsParse(doc)
				let pathA = path + "\(doc.documentID)/"
				team.path = pathA
				print("dlTeam.scouting = \(team.scouting)")
				teamArray.append(team)
			}
			completion(teamArray, nil)
				
		}
			
	}
	
	/*
	func dlScouts(db: Firestore, path: String, completion: @escaping ([ScoutingData], Error?) -> Void) {
		var scoutArray = [ScoutingData]()
		let query = db.collection(path)
		query.getDocuments { snapshot, error in
			if let error = error {
				print("Error downloading scouts: \(error)")
				completion(scoutArray, error)
				return
			}
			for doc in snapshot!.documents {
				let scout = self.parser.scoutParse(doc)
				scoutArray.append(scout)
			}
			completion(scoutArray, nil)
			
		}
		
	}*/
		
}
