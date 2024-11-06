//
//  OpenSkyApiPath.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 05/11/2024.
//

import Foundation

struct OpenSkyApiPath: Codable{
    let icao24: String
    let startTime: Int
    let endTime: Int
    let callsign: String
    let path: [Path]
}
