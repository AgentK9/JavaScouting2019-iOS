//
//  ScoutViewController.swift
//  JavaScouting2019
//
//  Created by Keegan on 1/28/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

class ScoutViewController: UIViewController {
	
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
	@IBOutlet var doneButton: UIButton!
	
	var isInitial: Bool!
	var matchNum: Int!
	var teamNum: Int!
	var outScout: ScoutingData = ScoutingData(matchID: -1, land: false, sample: -1, claim: false, park: false, depotMin: -1, landerMin: -1, endGame: -1)
	
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
		

        // Do any additional setup after loading the view.
    }
	
	@IBAction func onLandChange(_ sender: Any) {
		switch land.selectedSegmentIndex {
		case 0:
			outScout.land = true
		case 1:
			outScout.land = false
		default:
			print("unrecognized land segment index")
		}
	}
	@IBAction func onSampleChanged(_ sender: Any) {
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
	}
	@IBAction func onClaimChanged(_ sender: Any) {
		switch claim.selectedSegmentIndex {
		case 0:
			outScout.claim = true
		case 1:
			outScout.claim = false
		default:
			print("unknown selected claim index")
		}
	}
	@IBAction func onParkChanged(_ sender: Any) {
		switch park.selectedSegmentIndex {
		case 0:
			outScout.park = true
		case 1:
			outScout.park = false
		default:
			print("unknown selected park index")
		}
	}
	@IBAction func onDepotChanged(_ sender: Any) {
		outScout.depotMin = Int(depotMinStep.value)
		depotMinLabel.text = "\(outScout.depotMin)"
	}
	@IBAction func onLanderChanged(_ sender: Any) {
		outScout.landerMin = Int(landerMinStep.value)
		landerMinLabel.text = "\(outScout.landerMin)"
	}
	@IBAction func onEndGameChanged(_ sender: Any) {
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
		print(outScout)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
