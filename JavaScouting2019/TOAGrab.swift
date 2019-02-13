//
//  TOAGrab.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/12/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation

class TOAGrab {
	let apikey = "21df4a6153af99f984a195652c50434210d388743d4402830a8ab807af81f91b"
	func grabTeam(_ number: Int, completionHandler: @escaping (Data?, Error?) -> Void) -> ScoutingTeam
	{
		do {
			var toTeam: ScoutingTeam! = ScoutingTeam(teamNum: -1, teamName: nil, bestScore: nil, latestScore: nil, scouting: nil)
			let url = URL(string: "https://theorangealliance.org/api/team/\(number)")!
			var request = URLRequest(url: url)
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue(apikey, forHTTPHeaderField: "X-TOA-KEY")
			request.setValue("JavaScouting2019iOS", forHTTPHeaderField: "X-Application-Origin")
			var isDone = false
			
			let task = URLSession.shared.dataTask(with: request) { data, response, error in
				guard let data = data, error == nil else {
					completionHandler(nil, error)
					return
				}
				
				completionHandler(data, nil)
				let decoder = JSONDecoder()
				let teamdata = try! decoder.decode([TOATeamObj].self, from: data)
				let team = teamdata[0]
				if number == Int(team.team_key)! {
					toTeam.teamNum = number
					toTeam.teamName = team.team_name_short
				}
				isDone = true
				
			}

			task.resume()
			while isDone != true {
			}
			print()
			print(toTeam)
			print()
			return toTeam
		}
		catch {
			completionHandler(nil, error)
		}
		
	}
}

struct TOATeamObj: Codable {
	var team_key: String
	var region_key: String?
	var league_key: String?
	var team_number: Int?
	var team_name_short: String?
	var team_name_long: String?
	var robot_name: String?
	var last_active: String?
	var city: String?
	var state_prov: String?
	var zip_code: String?
	var country: String?
	var rookie_year: Int
	var website: String?
}
