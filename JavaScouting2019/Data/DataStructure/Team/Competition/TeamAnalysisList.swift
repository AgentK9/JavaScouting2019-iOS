//
//  TeamAnalysisList.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/18/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation
import FirebaseMLCommon
import FirebaseMLModelInterpreter

struct TeamAnalysisList {
	var teams: [ScoutingTeam]
	var matches: [Match]
	let grabber = FirebaseGrab()
	
	private func getTeamIndexByNumber(_ lteams: [ScoutingTeam], number: Int) -> Int? {
		let index = lteams.firstIndex(where: {$0.teamNum == number})
		return index
	}
	
	func getProjected() -> [ScoutingTeam] {
		var localTeams = self.teams
		var rankedTeams = [ScoutingTeam]()
		for match in matches {
			let results = match.getMatchResults(teams: localTeams)
			var matchTeams = [ScoutingTeam]()
			
			for team in match.redTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!

				if localTeams[index].QP == nil {
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Red" {
					localTeams[index].compRecord[0] += 1
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].compRecord[2] += 1
					localTeams[index].QP! += 1
				}
				else {
					localTeams[index].compRecord[1] += 1
				}
				
				if localTeams[index].TBP == nil {
					localTeams[index].TBP = 0
				}
				localTeams[index].TBP! += results["blue"] as! Float
				
				matchTeams.append(localTeams[index])
			}
			for team in match.blueTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					print("QP is nil")
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Blue" {
					localTeams[index].compRecord[0] += 1
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].compRecord[2] += 1
					localTeams[index].QP! += 1
				}
				else {
					localTeams[index].compRecord[1] += 1
				}
				
				if localTeams[index].TBP == nil {
					localTeams[index].TBP = 0
				}
				localTeams[index].TBP! += results["red"] as! Float
		
				matchTeams.append(localTeams[index])
			}
			
			for team in matchTeams {
				if let index = getTeamIndexByNumber(rankedTeams, number: team.teamNum) {
					rankedTeams[index] = team
				}
				else {
					rankedTeams.append(team)
				}
			}
		}
		
		rankedTeams.sort(by: {$0.TBP! > $1.TBP!})
		rankedTeams.sort(by: {$0.QP! > $1.QP!})
		
		return rankedTeams
	}
	
	func getActual() -> [ScoutingTeam] {
		var localTeams = teams
		var rankedTeams = [ScoutingTeam]()
		
		for match in matches {
			
			let results = match.getActualMatchResults(teams: localTeams)
			var matchTeams = [ScoutingTeam]()
			
			for team in match.redTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Red" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				if results["result"] as! String != "N" {
					if localTeams[index].TBP == nil {
						localTeams[index].TBP = 0
					}
					localTeams[index].TBP! += results["blue"] as! Float
					
					matchTeams.append(localTeams[index])
				}
			}
			for team in match.blueTeams {
				let index = getTeamIndexByNumber(localTeams, number: team)!
				
				if localTeams[index].QP == nil {
					print("QP is nil")
					localTeams[index].QP = 0
				}
				if results["result"] as! String == "Blue" {
					localTeams[index].QP! += 2
				}
				else if results["result"] as! String == "Tie" {
					localTeams[index].QP! += 1
				}
				if results["result"] as! String != "N" {
					if localTeams[index].TBP == nil {
						localTeams[index].TBP = 0
					}
					localTeams[index].TBP! += results["blue"] as! Float
					
					matchTeams.append(localTeams[index])
				}
			}
			
			for team in matchTeams {
				if let index = getTeamIndexByNumber(rankedTeams, number: team.teamNum) {
					rankedTeams[index] = team
				}
				else {
					rankedTeams.append(team)
				}
			}
		}
		
		rankedTeams.sort(by: {$0.TBP! > $1.TBP!})
		rankedTeams.sort(by: {$0.QP! > $1.QP!})
		
		return rankedTeams
	}
	
	func initAI() -> [Any] {
		let modelPath = Bundle.main.path(forResource: "adam", ofType: "tflite")
		let localModelSource = LocalModelSource(
			name: "adam",
			path: modelPath!
		)
		let registrationSuccessful = ModelManager.modelManager().register(localModelSource)
		let ioOptions = ModelInputOutputOptions()
		do {
			try ioOptions.setInputFormat(index: 0, type: .int32, dimensions: [1, 5, 1, 1, 1, 1])
			try ioOptions.setOutputFormat(index: 0, type: .float32, dimensions: [1, 1])
		} catch let error as NSError {
			print("Failed to set input or output format with error: \(error.localizedDescription)")
		}
		let options = ModelOptions(cloudModelName: nil, localModelName: "adam")
		return [options, ioOptions]
	}
	
	func getAIData(team: ScoutingTeam, options: [Any], completion: @escaping (Double, Error?) -> Void) {
		let interpreter = ModelInterpreter.modelInterpreter(options: options[0] as! ModelOptions)
		let inputs = ModelInputs()
		var inputData = Data()
		do {
			var teamData = [Float]()
			teamData.append(team.avgScore(type: "auto"))
			teamData.append(team.avgScore(type: "tele"))
			teamData.append(team.avgScore(type: "end"))
			teamData.append(team.avgScore(type: "total"))
			teamData.append(team.totalScoreDev())
			for i in 0...teamData.count-1 {
				let elementSize = MemoryLayout.size(ofValue: teamData[i])
				var bytes = [UInt8](repeating: 0, count: elementSize)
				memcpy(&bytes, &teamData[i], elementSize)
				inputData.append(&bytes, count: elementSize)
			}
			try inputs.addInput(inputData)
		} catch let error {
			print("Failed to add input: \(error)")
		}
		interpreter.run(inputs: inputs, options: options[1] as! ModelInputOutputOptions) { outputs, error in
			guard error == nil, let outputs = outputs else { print("error = \(error!)"); return }
			let output = try? outputs.output(index: 0) as? [[NSNumber]]
			let numA = output!![0]
			let rank = Double(truncating: numA[0])
			completion(rank, nil)
		}
	}
	
}
