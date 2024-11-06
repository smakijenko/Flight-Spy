//
//  LocationsDataService.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 29/09/2024.
//

import Foundation
import MapKit

class RegionsDatas {
    let regions: [Region] = [
        Region(
            coutryName: "Poland",
            center: CLLocationCoordinate2D(latitude: 52.04, longitude: 19.28),
            apiBorder: "lamin=49.0&lamax=54.5&lomin=14.1&lomax=24.1",
            borderArr: [49.0, 54.5, 14.1, 24.1]
        ),
        Region(
            coutryName: "Germany",
            center: CLLocationCoordinate2D(latitude: 51.16, longitude: 10.44),
            apiBorder: "lamin=47.2&lamax=55.1&lomin=5.9&lomax=15.0",
            borderArr: [47.2, 55.1, 5.9, 15.0]
        ),
        Region(
            coutryName: "France",
            center: CLLocationCoordinate2D(latitude: 46.60, longitude: 1.88),
            apiBorder: "lamin=41.3&lamax=51.1&lomin=-5.1&lomax=9.6",
            borderArr: [41.3, 51.1, -5.1, 9.6]
        ),
        Region(
            coutryName: "Spain and Portugal",
            center: CLLocationCoordinate2D(latitude: 40.46, longitude: -3.15),
            apiBorder: "lamin=36.0&lamax=43.8&lomin=-9.5&lomax=3.3",
            borderArr: [36.0, 43.8, -9.5, 3.3]
        ),
        Region(
            coutryName: "Great Britain",
            center: CLLocationCoordinate2D(latitude: 54.56, longitude: -4.2),
            apiBorder: "lamin=49.9&lamax=60.9&lomin=-10.5&lomax=1.8",
            borderArr: [49.9, 60.9, -10.5, 1.8]
        )
        ]
}
