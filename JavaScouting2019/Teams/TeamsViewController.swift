//
//  FirstViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/20/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

import FirebaseAuth

class TeamsViewController: UITableViewController {
	
	//var handle: Auth
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//handle = Auth.auth().addStateDidChangeListener { (auth, user) in }
		}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Teams"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let count = 0
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        return cell
    }
	
	@IBAction func unwindFromTeamDetail(segue: UIStoryboardSegue) {
	}
	@IBAction func unwindFromScoutingInit(segue: UIStoryboardSegue) {
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		//Auth.auth().removeStateDidChangeListener(handle!)
	}
	
}

