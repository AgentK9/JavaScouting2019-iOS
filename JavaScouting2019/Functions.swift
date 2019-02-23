//
//  Functions.swift
//  JavaScouting2019
//
//  Created by Noah Holoubek on 2/22/19.
//  Copyright © 2019 JavaScouts. All rights reserved.
//

import UIKit

protocol AlertController{}
extension AlertController where Self:UIViewController {
    
    func presentSimpleAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(controller, animated: true, completion: nil)
    }
    
    func presentConfirmationAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: completion))
        self.present(controller, animated: true, completion: nil)
    }
    
    func presentForceAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(controller, animated: true, completion: nil)
    }
}
