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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
