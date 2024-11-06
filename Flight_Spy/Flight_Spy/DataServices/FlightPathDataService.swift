//
//  FlightPathDataService.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 05/11/2024.
//

import Foundation
import MapKit

class FlightPathDataService: ObservableObject {
    var mapPoints: [CLLocationCoordinate2D]
    
    init() {
        mapPoints = []
    }
    
    func fetchPath(icao: String) async throws{
        mapPoints.removeAll()
        let url = URL(string: "https://login:password@opensky-network.org/api/tracks/all?icao24=\(icao)&time=0")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedPaths = try JSONDecoder().decode(OpenSkyApiPath.self, from: data)
        for decodedPath in decodedPaths.path{
            mapPoints.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(decodedPath.latitude), longitude: CLLocationDegrees(decodedPath.longitude)))
        }
    }
}
