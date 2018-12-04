//
//  BecomeViewController.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 21/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import Eureka

final class BecomeViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form
            
            +++ Section()
            <<< TextRow() {
                $0.title = "Name"
            }
            <<< EmailRow() {
                $0.title = "Email Address"
            }
            
            <<< PhoneRow() {
                $0.title = "Phone number"
        }
            <<< TextRow() {
                $0.title = "Address"
        }
        
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Submit"
        }
        
    }

}
