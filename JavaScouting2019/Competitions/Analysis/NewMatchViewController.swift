//
//  NewMatchViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 2/15/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class NewMatchViewController: UIViewController {

	@IBOutlet var Red1Label: UILabel!
	@IBOutlet var Red2Label: UILabel!
	@IBOutlet var Blue1Label: UILabel!
	@IBOutlet var Blue2Label: UILabel!
	
	var red1: ScoutingTeam!
	var red2: ScoutingTeam!
	var blue1: ScoutingTeam!
	var blue2: ScoutingTeam!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
    }

}
