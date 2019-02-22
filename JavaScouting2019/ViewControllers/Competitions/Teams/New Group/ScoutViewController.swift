//
//  ScoutViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit
import Firebase

class ScoutViewController: UIViewController {
	//MARK: - Storyboard Outlets
	@IBOutlet var navBar: UINavigationBar!
	@IBOutlet var land: UISegmentedControl!
	@IBOutlet var sample: UISegmentedControl!
	@IBOutlet var claim: UISegmentedControl!
	@IBOutlet var park: UISegmentedControl!
	@IBOutlet var depotMinLabel: UILabel!
	@IBOutlet var depotMinStep: UIStepper!
	@IBOutlet var landerMinLabel: UILabel!
	@IBOutlet var landerMinStep: UIStepper!
	@IBOutlet var endGame: UISegmentedControl!
	//MARK: - Variable Initialization
	var isInitial: Bool!
	var matchNum: Int!
	var teamNum: Int!
	var outScout: ScoutingData = ScoutingData(matchID: -1, land: false, sample: -1, claim: false, park: false, depotMin: -1, landerMin: -1, endGame: -1)
	var path: String!
	var db: Firestore!
	var editScout: Bool!
	//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if isInitial == true {
			navBar.topItem?.title = "\(teamNum!) Initial"
		}
		else {
			navBar.topItem?.title = "\(teamNum!) Match \(matchNum!)"
		}
		
		if matchNum == 0 {
			outScout.matchID = 0
		}
		else {
			outScout.matchID = matchNum
		}
		depotMinLabel.text = "\(0)"
		landerMinLabel.text = "\(0)"
		
		db = Firestore.firestore()
		
		if editScout {
			initEdit()
		}
		

        // Do any additional setup after loading the view.
    }
	//MARK: - Storyboard Refresh
	func initEdit() {
		
		switch outScout.land {
		case true: land.selectedSegmentIndex = 0
		case false: land.selectedSegmentIndex = 1
		default:
			print("unrecognized land value")
		}
		
		switch outScout.sample {
		case 0: sample.selectedSegmentIndex = 0
		case 1: sample.selectedSegmentIndex = 1
		case 2: sample.selectedSegmentIndex = 2
		case 3: sample.selectedSegmentIndex = 3
		default:
			print("unknown sample value")
		}
		
		switch outScout.claim {
		case true: claim.selectedSegmentIndex = 0
		case false: claim.selectedSegmentIndex = 1
		default:
			print("unknown selected claim index")
		}
		
		switch outScout.park {
		case true: park.selectedSegmentIndex = 0
		case false: park.selectedSegmentIndex = 1
		default:
			print("unknown selected park index")
		}
		
		depotMinStep.value = Double(outScout.depotMin)
		landerMinStep.value = Double(outScout.landerMin)
		
		switch outScout.endGame {
		case 0: endGame.selectedSegmentIndex = 0
		case 1: endGame.selectedSegmentIndex = 1
		case 2: endGame.selectedSegmentIndex = 2
		case 3: endGame.selectedSegmentIndex = 3
		default:
			print("unknown endgame segment index")
		}
	}
	func getOutScout() {
		
		switch land.selectedSegmentIndex {
		case 0:
			outScout.land = true
		case 1:
			outScout.land = false
		default:
			print("unrecognized land segment index")
		}
		
		switch sample.selectedSegmentIndex {
		case 0:
			outScout.sample = 0
		case 1:
			outScout.sample = 1
		case 2:
			outScout.sample = 2
		case 3:
			outScout.sample = 3
		default:
			print("unknown sample segment index")
		}
		
		
		switch claim.selectedSegmentIndex {
		case 0:
			outScout.claim = true
		case 1:
			outScout.claim = false
		default:
			print("unknown selected claim index")
		}
		
		
		switch park.selectedSegmentIndex {
		case 0:
			outScout.park = true
		case 1:
			outScout.park = false
		default:
			print("unknown selected park index")
		}
		
		
		outScout.depotMin = Int(depotMinStep.value)
		outScout.landerMin = Int(landerMinStep.value)
		
		switch endGame.selectedSegmentIndex {
		case 0:
			outScout.endGame = 0
		case 1:
			outScout.endGame = 1
		case 2:
			outScout.endGame = 2
		case 3:
			outScout.endGame = 3
		default:
			print("unknown endgame segment index")
		}
	}
	//MARK: - Storyboard Functions
	@IBAction func onLandChange(_ sender: Any) {
	}
	@IBAction func onSampleChanged(_ sender: Any) {
	}
	@IBAction func onClaimChanged(_ sender: Any) {
	}
	@IBAction func onParkChanged(_ sender: Any) {
	}
	@IBAction func onDepotChanged(_ sender: Any) {
		depotMinLabel.text = "\(Int(depotMinStep.value))"
	}
	@IBAction func onLanderChanged(_ sender: Any) {
		landerMinLabel.text = "\(Int(landerMinStep.value))"
	}
	@IBAction func onEndGameChanged(_ sender: Any) {
	}
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let identifier = segue.identifier
		switch identifier {
		case "unwindFromScout":
			getOutScout()
			db.document(path).updateData(["scouting": [outScout.dictionary]])
			let destination = segue.destination as! TeamDetailViewController
			destination.refresh()
			
		default:
			print("unknown segue identifier")
		}
    }

}
