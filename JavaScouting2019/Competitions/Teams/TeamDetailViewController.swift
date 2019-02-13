//
//  TeamDetailViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var selectedTeam: ScoutingTeam?
	
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var recordLabel: UILabel!
	@IBOutlet var scoutingItemTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navBar.topItem?.title = "\(selectedTeam!.teamName!) - \(selectedTeam!.teamNum)"

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
    }
	
	
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}

}
