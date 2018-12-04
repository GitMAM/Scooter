//
//  RideHistoryVC.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 21/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import Eureka

final class RideHistoryVC: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
        +++ Section()
            <<< SegmentedRow<String>("Ride History"){
                $0.options = ["All", "Personal", "Friends"]
        }
    }

}
