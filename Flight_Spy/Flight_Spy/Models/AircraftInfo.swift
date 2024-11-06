//
//  Aircraft.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 24/09/2024.
//

import Foundation

struct AircraftInfo: Identifiable, Codable, Equatable{
    
    var id: String
    var icoao24: String // can't be nil
    var callsign: String
    var originCountry: String // can't be nil
    var timePosition: Int
    var lastContact: Int // can't be nil
    var longitude: Float
    var latitude: Float
    var baroAltitude: Float
    var onGround: Bool // can't be nil
    var velocity: Float
    var trueTrack: Float
    var verticalRate: Float
    var sensors: [Int]
    var geoAltitude: Float
    var squawk: String
    var spi: Bool // can't be nil
    var positionSource: Int // can't be nil
    
    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        icoao24 = try container.decode(String.self)
        callsign = try container.decodeIfPresent(String.self)?.trimmingCharacters(in: .whitespaces) ?? "Unknown"
        if callsign == ""{
            callsign = "Unknown"
        }
        originCountry = try container.decode(String.self)
        timePosition = try container.decodeIfPresent(Int.self) ?? 0
        lastContact = try container.decode(Int.self)
        longitude = try container.decodeIfPresent(Float.self) ?? 0
        latitude = try container.decodeIfPresent(Float.self) ?? 0
        baroAltitude = try container.decodeIfPresent(Float.self) ?? 0
        onGround = try container.decode(Bool.self)
        velocity = try container.decodeIfPresent(Float.self) ?? 0
        trueTrack = try container.decodeIfPresent(Float.self) ?? 361 // 361 means nil, for aircraft annotation
        verticalRate = try container.decodeIfPresent(Float.self) ?? 0
        sensors = try container.decodeIfPresent([Int].self) ?? []
        geoAltitude = try container.decodeIfPresent(Float.self) ?? 0
        squawk = try container.decodeIfPresent(String.self) ?? "Unknown"
        spi = try container.decode(Bool.self)
        positionSource = try container.decode(Int.self)
        id = icoao24
    }
}
