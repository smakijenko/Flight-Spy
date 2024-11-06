//
//  MainViewModel.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 29/09/2024.
//

import Foundation
import MapKit
import SwiftUI

class MainViewModel: ObservableObject{
    @Published var regions: [Region]
    @Published var mapPosition: MapCameraPosition
    @Published var userLocation: CLLocationCoordinate2D
    @Published var userIconAnimating: Bool
    @Published var regionText: String
    @Published var showRegionsList: Bool
    @Published var apiRegionString: String
    @Published var isRefreshing: Bool
    @Published var showIntervalList: Bool
    @Published var interval: Int
    @Published var counter: Int
    @Published var intervals: [Int]
    @Published var northWestPointOfView: CLLocationCoordinate2D
    @Published var southEastPointOfView: CLLocationCoordinate2D
    @Published var scale: Double
    @Published var diagonal: Double
    
    init() {
        regions = RegionsDatas().regions
        mapPosition = .firstCamPosition
        userLocation = CLLocationCoordinate2D(latitude: 1000, longitude: 1000)
        userIconAnimating = false
        regionText = "Regions list"
        showRegionsList = false
        apiRegionString = ""
        isRefreshing = false
        showIntervalList = false
        interval = 10
        counter = 10
        intervals = [5, 10, 15, 20]
        northWestPointOfView = CLLocationCoordinate2D(latitude: 67.4555717629076, longitude: 2.7551000000000236)
        southEastPointOfView = CLLocationCoordinate2D(latitude: 35.65853395736387, longitude: 27.755100000000095)
        scale = 1.0
        diagonal = 0
    }
    
    func centerUser(locationManager: LocationManager){
        userLocation.latitude = locationManager.lastKnownLocation?.latitude ?? 1000
        userLocation.longitude = locationManager.lastKnownLocation?.longitude ?? 1000
    }
    
    func toggleRegionsList(){
        withAnimation {
            showRegionsList.toggle()
        }
    }
    
    func closeRegionSelection(){
        withAnimation {
            showRegionsList = false
        }
    }
    
    func setMapPosition(locationCenter: CLLocationCoordinate2D){
        withAnimation {
            mapPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: locationCenter,
                span: MKCoordinateSpan(latitudeDelta: 13.0, longitudeDelta: 13.0)))
        }
    }
    
    func setRegionSettings(region: Region){
        regionText = region.coutryName
        apiRegionString = region.apiBorder
        setMapPosition(locationCenter: region.center)
        isRefreshing = true
        closeRegionSelection()
        counter = interval
    }
        
    func checkUserRegion() -> Bool{
        if userLocation.latitude == 1000 || userLocation.longitude == 1000 {return false}
        
        withAnimation{
            userIconAnimating = true
        }
        
        for region in regions {
            if region.borderArr[0] ... region.borderArr[1] ~= userLocation.latitude && region.borderArr[2] ... region.borderArr[3] ~= userLocation.longitude{
                setRegionSettings(region: region)
                return true
            }
        }
        
        closeRegionSelection()
        regionText = "Regions list"
        setMapPosition(locationCenter: userLocation)
        isRefreshing = false
        
        return false
    }
    
    func toggleIntervalList(){
        withAnimation {
            showIntervalList.toggle()
        }
    }
    
    func closeIntervalSelection(){
        withAnimation {
            showIntervalList = false
        }
    }
    
    func chooseInterval(inInterval: Int){
        interval = inInterval
        counter = inInterval
        closeIntervalSelection()
    }
    
    func updateVisibleAreaAndScale(context: MapCameraUpdateContext){
        let southEast = MKMapPoint(
            x: context.rect.origin.x + context.rect.size.width,
            y: context.rect.origin.y + context.rect.size.height
        )
        northWestPointOfView = context.rect.origin.coordinate
        southEastPointOfView = southEast.coordinate
        
        let size = context.rect.size
        let c = sqrt((pow(size.width, 2) + pow(size.height, 2)))
        if diagonal == 0 {diagonal = c}
        scale = (diagonal / c) / 1.92
        if scale > 2.3 {scale = 2.3}
        else if scale < 0.5 {scale = 0.5}
    }
    
    func setDefaultRegionSettings(){
        closeRegionSelection()
        regionText = "Regions list"
        isRefreshing = false
        withAnimation{
            mapPosition = .firstCamPosition
        }
    }
}
