//
//  OpenSkyApiAircraft.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 25/09/2024.
//

import Foundation

struct OpenSkyApiAircraft: Codable {
    let time: Int
    let states: [AircraftInfo]
}
