//
//  LauchScreen.swift
//  Time Reminder
//
//  Created by Maxence Gama on 18/04/2021.
//

import Foundation
import UIKit

class LauchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (t) in
            self.performSegue(withIdentifier: "lauchToMain", sender: self)
        }
    }
}
