//
//  Path.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 05/11/2024.
//

import Foundation

struct Path: Codable, Identifiable{
    let id: UUID
    let time: Int // cant be nil
    let latitude: Float
    let longitude: Float
    let baro_altitude: Float
    let true_track: Float
    let on_ground: Bool // cant be nil
    
    init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        id = UUID()
        time = try container.decode(Int.self)
        latitude = try container.decodeIfPresent(Float.self) ?? 0
        longitude = try container.decodeIfPresent(Float.self) ?? 0
        baro_altitude = try container.decodeIfPresent(Float.self) ?? 0
        true_track = try container.decodeIfPresent(Float.self) ?? 0
        on_ground = try container.decode(Bool.self)
    }
}
