//
//  AnalysisViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/18/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet var tableView: UITableView!
	
	var teams: [ScoutingTeam]!
	var matches: [Match]!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Analysis"

        // Do any additional setup after loading the view.
    }
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = 0
		return count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "rankedMatchCell", for: indexPath)
		
		return cell
	}


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
