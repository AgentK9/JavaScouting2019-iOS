//
//  Data.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/21/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import Foundation
import UIKit

struct teamData {
	let apiKey = "21df4a6153af99f984a195652c50434210d388743d4402830a8ab807af81f91b"
    var teams: [Team] = [Team]()
    var comps: [Competition] = [Competition]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    init() {
        refresh("teams")
		refresh("competitions")
    }
	
    mutating func refresh(_ type: String) {
		do {
			switch type {
			case "teams":
				teams = try context.fetch(Team.fetchRequest())
				print(type)
			case "competitions":
				comps = try context.fetch(Competition.fetchRequest())
				print(type)
			default:
				print("error reading " + type)
			}
		}
		catch {
			print("Error Fetching Data")
		}
		
    }
}

