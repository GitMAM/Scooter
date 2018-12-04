//
//  ViewController.swift
//  Scooter
//
//  Created by Mohamed Ibrahim on 19/10/2018.
//  Copyright © 2018 NewBeginning. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth
import SideMenu

final class ViewController: UIViewController {
    
    var userLocation: CLLocation?

    let mapView: MKMapView = {
        let mp = MKMapView()
        return mp
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "PetLocationpng"), for: .normal)
        btn.addTarget(self, action: #selector(createSightindg), for: .touchUpInside)
        return btn
    }()
    
    
    let rideButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("RIDE", for: .normal)
        btn.setTitleColor(UIColor.primary, for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont(name: "Nunito-Bold", size: 17)
        btn.addTarget(self, action: #selector(showScanner), for: .touchUpInside)
        btn.layer.cornerRadius = 50
        btn.clipsToBounds = true
        btn.layer.borderColor = UIColor.primary.cgColor
        btn.layer.borderWidth = 4
        return btn
    }()
    
    
    var mapHasCenteredOnce = false
    
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    
    let locationManager = CLLocationManager()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        
        let navigationWithImage = UIBarButtonItem(image:  #imageLiteral(resourceName: "LeftMenuIcon").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showMenue))
        navigationItem.leftBarButtonItem = navigationWithImage
        
        let rightBar = UIBarButtonItem(image:  #imageLiteral(resourceName: "question").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(showInstructions))
        navigationItem.rightBarButtonItem = rightBar
        
        view.addSubview(mapView)
        mapView.addSubview(button)
        mapView.addSubview(rideButton)
        navigationItem.title = "Nearby Scooters"
       
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func showMenue() {
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: SideMenuVC())
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        guard let menu = SideMenuManager.default.menuLeftNavigationController else {return}

        SideMenuManager.default.menuEnableSwipeGestures = true
        SideMenuManager.default.menuWidth = view.frame.width - 150

        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController?.view ?? UIView())
        SideMenuManager.default.menuFadeStatusBar = false
        present(menu, animated: true, completion: nil)

    }
    
    
    
    @objc func createSightindg() {
//            let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
//
//            let rand = arc4random_uniform(99) + 1
//            createSighting(forLocation: loc, withPokemon: Int(rand))
        
        guard let location = userLocation else {return}
        centerMapOnLocation(location: location)
    }
    
    @objc func showScanner() {
        let controller = ScannerViewController()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func showInstructions() {
        self.present(OnBoardingVC(), animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.frame
        button.anchor(top: nil, left: mapView.leftAnchor, bottom: mapView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -8, paddingRight: 0, width: 60, height: 60)
        rideButton.anchor(top: nil, left: nil, bottom: mapView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -16, paddingRight: 0, width: 100, height: 100)
        rideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func createSighting(forLocation location: CLLocation, withPokemon pokeId: Int) {
        
        geoFire.setLocation(location, forKey: "\(pokeId)")
    }
    
    
    func showSightingsOnMap(location: CLLocation) {
        
        let circleQuery = geoFire?.query(at: location, withRadius: 20)
        _ = circleQuery?.observe(GFEventType.keyEntered, with: { (key, location) in
            let location = location
            let anno = Scooter(coordinate: location.coordinate, discipline: "", subtitle: "", title: "Scooter")
                self.mapView.addAnnotation(anno)
//            }
        })
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        showSightingsOnMap(location: loc)
    }

}

extension ViewController : MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            self.userLocation = loc
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                showSightingsOnMap(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }

}


extension ViewController: QRCodeScannedProtocol {
    func QRCode(code: String) {
        present(TimerViewController(), animated: false, completion: nil)
    }
}

class CustomButton: UIButton {
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 50).cgPath
            shadowLayer.fillColor = UIColor.primary.cgColor
            
            shadowLayer.shadowColor = UIColor.primary.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
