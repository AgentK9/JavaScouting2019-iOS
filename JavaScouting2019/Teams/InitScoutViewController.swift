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
	@IBOutlet var compField: UITextField!
	@IBOutlet var initMatch: UISegmentedControl!
	@IBOutlet var matchNumField: UITextField!
	@IBOutlet var goButton: UIButton!
	
	var matchNum: Int = 0
	var teamNum: Int = 0
	var comp: String = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navBar!.topItem!.title = "New Scouting Item"

        // Do any additional setup after loading the view.
    }
	
	@IBAction func initMatchChanged(_ sender: Any) {
		let selected = initMatch.selectedSegmentIndex
		
		if selected == 0 {
			matchNumField.isEnabled = false
			matchNum = 0
		}
		else {
			matchNumField.isEnabled = true
		}
	}
	
	@IBAction func goToScout(_ sender: Any) {
		var goodToContinue = true
		
		if let text = matchNumField.text {
			if let num = Int(text) {
				teamNum = num
			}
			else {
				goodToContinue = false
			}
		}
		else {
			goodToContinue = false
		}
		if let text = compField.text {
			comp = text
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
		if goodToContinue {
			performSegue(withIdentifier: "goToScout", sender: self)
		}
		else {
			raiseInvalidInputToUser()
		}
		
	}
	
	func raiseInvalidInputToUser() {
		print("Invalid Input")
		// add other code here to let user know
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "goToScout":
			let destination = segue.destination as! ScoutViewController

		default:
			print("Unrecognized segue identifier")
		}
    }

}