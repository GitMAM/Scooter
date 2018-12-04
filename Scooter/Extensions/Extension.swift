//
//  Extension.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 20/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static func random() -> UIColor {
        let r = CGFloat(arc4random() % 255)
        let g = CGFloat(arc4random() % 255)
        let b = CGFloat(arc4random() % 255)
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    public static var primary: UIColor {
        return UIColor(red: 206.0/255.0, green: 19.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }
    
    
    public static var secondPrimary: UIColor {
        return UIColor(red: 190/255.0, green: 19.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }
    
    public static var secondary: UIColor {
        return UIColor.white
    }
    
    public static func blueSystem() -> UIColor {
        return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    }
    
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}


extension UIColor {
    
    static let firstRed = UIColor.rgb(r: 233, g: 150, b: 122)
    static let secondRed = UIColor.rgb(r: 240, g: 128, b: 128)
    static let thirdRed = UIColor.rgb(r: 205, g: 92, b: 92)
    static let fourthRed = UIColor.rgb(r: 220, g: 20, b: 60)
    static let fifthRed = UIColor.primary
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgbWithAlpha(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
}
