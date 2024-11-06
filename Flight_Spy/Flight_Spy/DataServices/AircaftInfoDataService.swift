//
//  AircaftInfoDataService.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 25/09/2024.
//

import Foundation
import SwiftUI

class AircaftInfoDataService: ObservableObject {
    var decodAircrafts: [AircraftInfo]
    @Published var aircrafts: [AircraftInfo]
    @Published var showOnGround: Bool
    @Published var pulstatorAnimating: Bool
    @Published var showAircraftsAlert: Bool
    
    init () {
        decodAircrafts = []
        aircrafts = []
        showOnGround = false
        pulstatorAnimating = false
        showAircraftsAlert = false
    }
    
    func fetchAircraftInfo(region: String) async throws{
        let url = URL(string: "https://login:password@opensky-network.org/api/states/all?\(region)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedAircrafts = try JSONDecoder().decode(OpenSkyApiAircraft.self, from: data)
        decodAircrafts = decodedAircrafts.states
    }
    
    func getAicrafts(region: String) {
        Task {
            do{
                try await fetchAircraftInfo(region: region)
            }
            catch{
                showAircraftsAlert.toggle()
            }
            DispatchQueue.main.async { [self] in
                pulstatorAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    aircrafts = decodAircrafts
                    pulstatorAnimating = false
                }
            }
        }
    }
}
