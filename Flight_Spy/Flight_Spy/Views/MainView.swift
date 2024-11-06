//
//  ContentView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 24/09/2024.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject private var acData: AircaftInfoDataService
    @EnvironmentObject private var mainVm: MainViewModel
    @EnvironmentObject private var slideVm: SlideFlightInfoViewModel
    var body: some View {
        ZStack{
            mapView
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            FindMeView()
                            OnGroundView()
                        }
                    }
                    Spacer()
                    CountryPickerView()
                }
                VStack{
                    HStack{
                        PulsatorView()
                        Spacer()
                    }
                    Spacer()
                }
            }
            .disabled(slideVm.showSlideFlightInfoView ? true : false)
            HStack {
                if slideVm.showSlideFlightInfoView{
                    SlideFlightInfoView()
                        .transition(.move(edge: .leading))
                }
                Spacer()
            }
        }
        .alert(isPresented: $acData.showAircraftsAlert) {
            Alert(
                title: Text("Can not find aircrafts."),
                message: Text("Try again later."),
                dismissButton: .default(Text("Ok"), action: {
                    mainVm.setDefaultRegionSettings()
                }))
        }
        .alert(isPresented: $slideVm.showSlideInfoAlert) {
            Alert(
                title: Text("Can not find info about that flight."),
                message: Text("Try again later."),
                dismissButton: .default(Text("Ok"), action: {
                    slideVm.closeSlideFlightInfoView()
                }))
        }
        .alert(isPresented: $slideVm.showPathAlert) {
            Alert(
                title: Text("Can not find path of that flight."),
                message: Text("Try again later."),
                dismissButton: .default(Text("Ok"), action: {
                    slideVm.closePath()
                }))
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AircaftInfoDataService())
        .environmentObject(MainViewModel())
        .environmentObject(SlideFlightInfoViewModel())
}

extension MainView{
    private var mapView: some View{
        Map(position: $mainVm.mapPosition){
            // User location annotation
            if mainVm.userLocation.latitude != 1000 && mainVm.userLocation.longitude != 1000{
                Annotation("My location", coordinate: mainVm.userLocation, anchor: .bottom) {
                    UserLocationAnnotation()
                }
            }
            
            // Aircrafts locations annotations
            if  !slideVm.isPathShown{
                // shows aircrafts
                if acData.aircrafts.count > 0{
                    ForEach(acData.aircrafts) { ac in
                        let location = CLLocationCoordinate2D(
                            latitude: CLLocationDegrees(ac.latitude),
                            longitude: CLLocationDegrees(ac.longitude))
                        // if we want aicrafts on ground or airborn + it shows only aircrfts visible on the screen
                        if ac.onGround == acData.showOnGround && mainVm.northWestPointOfView.longitude ... mainVm.southEastPointOfView.longitude ~= location.longitude && mainVm.southEastPointOfView.latitude ... mainVm.northWestPointOfView.latitude ~= location.latitude{
                            Annotation("", coordinate: location, anchor: .bottom) {
                                AircraftLocationAnnotation(acTrack: Double(ac.trueTrack), onGround: ac.onGround)
                                    .scaleEffect(mainVm.scale)
                                    .onTapGesture {
                                        slideVm.openSlideFlightInfoView(ac: ac)
                                    }
                            }
                        }
                    }
                }
                // shows path of the aicraft from slide view, can use ! because of if statement
            }else{
                if slideVm.flightPath.count >= 2{
                    // Airport
                    let airportLocation = CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(slideVm.flightPath.first!.latitude),
                        longitude: CLLocationDegrees(slideVm.flightPath.first!.longitude))
                    Annotation("", coordinate: airportLocation, anchor: .bottom) {
                        AirportPinAnnotation()
                            .scaleEffect(mainVm.scale)
                    }
                    
                    // Path
                    MapPolyline(coordinates: slideVm.flightPath)
                        .stroke(.appPurple, lineWidth: 4)
                    
                    // Aircraft
                    if let ac = slideVm.acInfo{
                        let aircraftLocation = CLLocationCoordinate2D(
                            latitude: CLLocationDegrees(slideVm.flightPath.last!.latitude),
                            longitude: CLLocationDegrees(slideVm.flightPath.last!.longitude))
                        Annotation("", coordinate: aircraftLocation, anchor: .bottom) {
                            AircraftLocationAnnotation(acTrack: Double(ac.trueTrack), onGround: ac.onGround)
                                .scaleEffect(mainVm.scale)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onMapCameraChange { context in
            mainVm.updateVisibleAreaAndScale(context: context)
        }
    }
}

