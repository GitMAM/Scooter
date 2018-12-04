//
//  PokeAnnotation.swift
//  PokeFinder
//
//  Created by Mark Price on 7/25/16.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import Foundation
import MapKit


final class Scooter: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let discipline: String
    let subtitle: String?
    let title: String?

    
    init(coordinate: CLLocationCoordinate2D, discipline: String, subtitle: String?, title: String?) {
        self.coordinate = coordinate
        self.discipline = discipline
        self.subtitle = subtitle
        self.title = title
    }
    
    var imageName: String? {
        if discipline == "Sculpture" { return "Statue" }
        return "flag"
    }
    
}

