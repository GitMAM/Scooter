//
//  PaymentViewController.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 21/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import Eureka
import CreditCardRow


final class PaymentViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreditCardRow.defaultRowInitializer = {
            $0.cellProvider = CellProvider<CreditCardCell>(nibName: "CustomCell", bundle: nil)
        }
        
        form +++ Section()
            <<< CreditCardRow() {
                $0.numberSeparator = "-"
                $0.expirationSeparator = "-"
                $0.maxCreditCardNumberLength = 16
                $0.maxCVVLength = 3
            }
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Save"
        }
        
    }
    
}
