//
//  Location.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 29/09/2024.
//

import Foundation
import MapKit

struct Region: Identifiable{
    let id = UUID()
    let coutryName: String
    let center: CLLocationCoordinate2D
    let apiBorder: String
    let borderArr: [Double]
}
