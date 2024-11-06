//
//  FlightInfo.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 19/10/2024.
//
import Foundation

struct FlightInfo: Decodable{
    let originCity: String
    let destinationCity: String
    let schedDeparture: String
    let schedArrival: String
    let departureDate: String
    let arrivalDate: String
    let progress: String
    let flightNum: String
    let airlineLogoLink: String
    let airline: String
    let aircraftModel: String
    let registration: String
    let imgLink: String
}
