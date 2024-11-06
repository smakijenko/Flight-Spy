//
//  Extensions.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 28/09/2024.
//

import Foundation
import MapKit
import SwiftUI


extension MapCameraPosition{
    //europe view
    static let firstCamPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 54.5260, longitude: 15.2551),
        span: MKCoordinateSpan(latitudeDelta: 25.0, longitudeDelta: 25.0)))
}
