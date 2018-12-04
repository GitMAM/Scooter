//
//  TimerViewController.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 20/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import PMAlertController
import MapKit

final class TimerViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    
    let mapView: MKMapView = {
        let mp = MKMapView()
        return mp
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.textColor = UIColor.gray
        label.sizeToFit()
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let finishTrip: UIButton = {
        let btn = UIButton()
        btn.setTitle("End", for: .normal)
        btn.setTitleColor(UIColor.primary, for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 17)
        btn.addTarget(self, action: #selector(finishTripFunction), for: .touchUpInside)
        btn.layer.cornerRadius = 50
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.primary.cgColor
        btn.layer.borderWidth = 4
        return btn
    }()
    
    var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        textLabel.textAlignment = .left

        view.addSubview(mapView)
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: view.bounds.height * 0.75)
        view.addSubview(footerView)
        footerView.anchor(top: mapView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(finishTrip)
        finishTrip.anchor(top: footerView.topAnchor, left: nil, bottom: nil , right: footerView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 100, height: 100)
        
        
        view.addSubview(textLabel)
        textLabel.anchor(top: footerView.topAnchor, left: footerView.leftAnchor, bottom: nil, right: finishTrip.rightAnchor, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        

    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } 
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(processTimer)), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    
    @objc func finishTripFunction() {
        timer.invalidate()
        
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: counter)
        
        let hourCharge = (Double(h * 60) * 0.15)
        let minuteCharge = (Double(m) * 0.15)
        let secondCharge = (Double(s) * 0.0025)
        let charge = hourCharge + minuteCharge + secondCharge + 1
        
        
        let alertVC = PMAlertController(title:"Thank you", description: "Thanks for taking a trip with us, hope you enjoyed it. You have been charged \(charge)$, we will send you a receipt. Don't forget to not block any enterance or side walk when leaving the scooter.", image: UIImage(named: "clap.png"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Done", style: .default, action: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
    @objc func processTimer() {
        counter += 1
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: counter)
        textLabel.text = ("\(h) : \(m) : \(s)")
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
