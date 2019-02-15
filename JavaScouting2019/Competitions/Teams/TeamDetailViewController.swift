//
//  TeamDetailViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var recordLabel: UILabel!
	@IBOutlet var scoutingItemTable: UITableView!
	
	var selectedTeam: ScoutingTeam?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navBar.topItem?.title = "\(selectedTeam!.teamName!) - \(selectedTeam!.teamNum)"
		recordLabel.text = "Season Record: " + selectedTeam!.record!

        // Do any additional setup after loading the view.
    }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = 0 + 1
		return count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "addScoutingCell", for: indexPath)
			return cell

		}
		else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "itemScoutingCell", for: indexPath)
			let row = indexPath.row - 1
			return cell
		}
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "detailToNewScout":
			let destination = segue.destination as! InitScoutViewController
			
			destination.teamNum = self.selectedTeam?.teamNum
			
		default:
			print("unknown segue identifier")
		}
    }
	
	
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}

}
