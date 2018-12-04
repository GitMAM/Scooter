//
//  SettingsViewController.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 21/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import Eureka

final class SettingsViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
            +++ Section()
            <<< TextRow() {
                $0.title = "Username"
                $0.value = "johndoe1"
            }
            <<< EmailRow() {
                $0.title = "Email Address"
                $0.value = "john@doe.com"
            }
            
            <<< PhoneRow() {
                $0.title = "Phone number"
                $0.value = "+353 8349961"
                $0.disabled = true
            }
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Notification Preference"
            }

            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Log out"
            }
            
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "About"
                }
        
    }

}
