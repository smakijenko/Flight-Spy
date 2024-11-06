//
//  FlightInfoDataService.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 28/10/2024.
//

import Foundation
class FlightInfoDataService {
    func fetchFlightInfo(flightCode: String) async -> FlightInfo?{
        let url = URL(string: "...flightSpyApi.php?flightCode=\(flightCode)")
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let decodedFlightInfo = try JSONDecoder().decode(FlightInfo.self, from: data)
            return decodedFlightInfo
        }
        catch {
            print("Error: \(error)")
            return nil
        }
    }
}
