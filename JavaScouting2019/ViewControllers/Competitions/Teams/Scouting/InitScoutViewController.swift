//
//  InitScoutViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class InitScoutViewController: UIViewController {

	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var teamNumField: UITextField!
	@IBOutlet var initMatch: UISegmentedControl!
	@IBOutlet var matchNumField: UITextField!
	@IBOutlet var goButton: UIButton!
	
	var isInitial: Bool!
	var matchNum: Int!
	var teamNum: Int!
	var comp: String!
	var path: String!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		matchNumField.isEnabled = true
		isInitial = false
		matchNum = 0
		comp = ""
		
		self.navBar!.topItem!.title = "New Scouting Item"

        // Do any additional setup after loading the view.
    }
	
	@IBAction func initMatchChanged(_ sender: Any) {
		let selected = initMatch.selectedSegmentIndex
		
		if selected == 0 {
			isInitial = true
			matchNumField.isEnabled = false
			matchNum = 0
		}
		else {
			isInitial = false
			matchNumField.isEnabled = true
		}
	}
	
	@IBAction func goToScout(_ sender: Any) {
		var goodToContinue = true
		
		if let text = matchNumField.text {
			if let num = Int(text) {
				matchNum = num
			}
			else {
				goodToContinue = false
			}
		}
		else {
			goodToContinue = false
		}
		if let text = matchNumField.text {
			if let num = Int(text) {
				matchNum = num
			}
			else {
				goodToContinue = false
			}
		}
		else {
			goodToContinue = false
		}
		if goodToContinue == false {
			raiseInvalidInputToUser()
		}
		
	}
	
	func raiseInvalidInputToUser() {
		print("Invalid Input")
		// add other code here to let user know
	}
	
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "goToScout":
			let destination = segue.destination as! ScoutViewController
			
			destination.isInitial = self.isInitial
			destination.matchNum = self.matchNum
			destination.teamNum = self.teamNum
			destination.editScout = false
			destination.path = self.path
			
		default:
			print("Unrecognized segue identifier")
		}
    }
	@IBAction func unwindFromScoutingDetail(segue: UIStoryboardSegue) {
	}

}
