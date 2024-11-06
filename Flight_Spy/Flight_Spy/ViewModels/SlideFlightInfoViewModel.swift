//
//  SlideFlightInfoViewModel.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 30/10/2024.
//

import Foundation
import SwiftUI
import MapKit

class SlideFlightInfoViewModel: ObservableObject{
    private var pathData = FlightPathDataService()
    @Published var showSlideFlightInfoView: Bool
    @Published var scale: CGFloat
    @Published var isOut: Bool
    @Published var offset: CGFloat
    @Published var acInfo: AircraftInfo?
    @Published var isDataLoaded: Bool
    @Published var isPathShown: Bool
    @Published var flightInfo: FlightInfo
    @Published var isAcInfoOpen: Bool
    @Published var showSlideInfoAlert: Bool
    @Published var showPathAlert: Bool
    @Published var flightPath: [CLLocationCoordinate2D]
    
    private let unknownFlightInfo = FlightInfo(
        originCity: "Unknown",
        destinationCity: "Unknown",
        schedDeparture: "Unknown",
        schedArrival: "Unknown",
        departureDate: "Unknown",
        arrivalDate: "Unknown",
        progress: "0",
        flightNum: "Unknown",
        airlineLogoLink: "Unknown",
        airline: "Unknown",
        aircraftModel: "Unknown",
        registration: "Unknown",
        imgLink: "Unknown"
    )
    
    init() {
        showSlideFlightInfoView = false
        scale = UIScreen.main.bounds.height / 852
        isOut = true
        offset = 0
        isDataLoaded = false
        isPathShown = false
        flightInfo = unknownFlightInfo
        isAcInfoOpen = false
        showSlideInfoAlert = false
        showPathAlert = false
        flightPath = []
    }
    
    func openSlideFlightInfoView(ac: AircraftInfo){
        withAnimation{
            showSlideFlightInfoView = true
            isOut = false
            acInfo = ac
        }
    }
    
    func closeSlideFlightInfoView(){
        withAnimation {
            showSlideFlightInfoView = false
            isOut = true
            offset = 0
        }
        isDataLoaded = false
        flightInfo = unknownFlightInfo
        isAcInfoOpen = false
        showSlideInfoAlert = false
    }
    
    func checkFlightInfo(info: FlightInfo) -> Bool{
        var counter = 0
        let mirror = Mirror(reflecting: info)
        for (key, value) in mirror.children {
            if key == "flightNum"{
                if value as! String != "UNKNOWN" && value as! String != ""{
                    counter += 1
                }
            }
            if key == "airline"{
                if value as! String != "UNKNOWN" && value as! String != ""{
                    counter += 1
                }
            }
            if counter == 2{
                return true
            }
        }
        if !showSlideInfoAlert {showSlideInfoAlert.toggle()}
        return false
    }
    
    func showLoadedFlightInfo(info: FlightInfo){
        withAnimation {
            flightInfo = info
            isDataLoaded = true
        }
    }

    func showPath(){
        if isDataLoaded {
            if let acInfo = acInfo{
                Task{
                    do{
                        try await pathData.fetchPath(icao: acInfo.icoao24)
                    }
                    catch{
                        showPathAlert.toggle()
                    }
                    if !pathData.mapPoints.isEmpty{
                        DispatchQueue.main.async { [self] in
                            flightPath = pathData.mapPoints
                            withAnimation {
                                isPathShown = true
                                offset = -260 * scale
                            }
                        }
                    }
                }
            }
        }
    }

    
    func closePath(){
        withAnimation {
            offset = 0
            isPathShown = false
            flightPath = []
        }
    }
    
    func toogleAcInfo(){
        withAnimation(.easeInOut(duration: 0.5)){
            if isDataLoaded{
                isAcInfoOpen.toggle()
            }
        }
    }
}
