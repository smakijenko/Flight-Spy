//
//  slideExtentions.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 01/11/2024.
//

import Foundation
import SwiftUI
import Shimmer

extension SlideFlightInfoView{
    // Background
    var background: some View {
        Rectangle()
            .foregroundStyle(.ultraThinMaterial)
    }
    
    // Loaded view - Path arrow button
    var pathButton: some View{
        Button {
            slideVm.closePath()
        } label: {
            HStack{
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundStyle(Color.primary)
                    .font(.title3)
                    .padding(.top)
                    .padding(.horizontal)
                    .animation(.none, value: slideVm.isPathShown)
            }
        }
    }
    
    // Loaded view - Aircraft image
    var airlineLogo: some View {
        AsyncImage(url: URL(string: slideVm.flightInfo.airlineLogoLink)) { Image in
            Image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 40)
        } placeholder: {
            ProgressView()
        }
    }
    
    var aircraftImage: some View {
        VStack(spacing: 0){
            AsyncImage(url: URL(string: slideVm.flightInfo.imgLink)) { loadedImage in
                loadedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(alignment: .bottom) {
                        Text(slideVm.flightInfo.aircraftModel + ", " + slideVm.flightInfo.registration)
                            .foregroundStyle(.white)
                            .font(.callout)
                            .scaledToFit()
                            .minimumScaleFactor(0.1)
                            .padding(5)
                            .background(.barGrey)
                            .clipShape(.rect(topLeadingRadius: 5, topTrailingRadius: 5))
                    }
            } placeholder: {
                shimmerRect(radius: 10, w: nil, h: 180)
            }
        }
        .padding()
        .shadow(radius: 5)
    }
    
    // Loaded view - Airline name
    var airlineName: some View {
        Text(slideVm.flightInfo.airline.uppercased() + ", " + slideVm.flightInfo.flightNum.uppercased())
            .foregroundStyle(.primary)
            .font(.callout)
            .scaledToFit()
            .minimumScaleFactor(0.1)
            .padding(.horizontal)
    }
    
    // Loaded view - Progress bar
    var progressBar: some View {
        HStack {
            let progressOffset = ((CGFloat(Int(slideVm.flightInfo.progress)!) / 100) * 170)
            Image(systemName: "airplane.departure")
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 6)
                .overlay(alignment: .leading) { // .trailing is offset: 170
                    Image(systemName: "airplane")
                        .foregroundStyle(invertedColor)
                        .offset(x: progressOffset)
                }
            Image(systemName: "airplane.arrival")
        }
        .foregroundStyle(.primary)
        .font(.title2)
        .padding(.horizontal)
    }
    
    // Loaded view - AcInfo
    
    var acInfo: some View{
        ZStack{
            if let ac = slideVm.acInfo{
            HStack{
                VStack(alignment: .leading, spacing: 11){
                    acInfoIcon(name: "latitudeIcon")
                    acInfoIcon(name: "longitudeIcon")
                    acInfoIcon(name: "altitudeIcon")
                    acInfoIcon(name: "velocityIcon")
                    acInfoIcon(name: "trueTrackIcon")
                }
                VStack(alignment: .leading, spacing: 7){
                    Text("Latitude:")
                    Text("Longitude:")
                    Text("Baro altitude:")
                    Text("Ground velocity:")
                    Text("True track:")
                }
                .font(.body)
                Spacer()
                VStack(alignment: .trailing, spacing: 7){
                    Text("\(String(format: "%.4f", ac.latitude))")
                    Text("\(String(format: "%.4f", ac.longitude))")
                    Text("\(String(format: "%.2f", ac.baroAltitude)) m")
                    Text("\(String(format: "%.1f", ac.velocity)) m/s")
                    Text("\(String(format: "%.2f", ac.trueTrack))°")
                }
                .font(.headline)
            }
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    func acInfoIcon(name: String) -> some View {
        Image(colorScheme == .dark ? "\(name)White" : "\(name)Black")
            .resizable()
            .frame(width: 16, height: 16)
    }
    
    // Loaded view - Schedules
    var schedules: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(slideVm.flightInfo.originCity)
                        .font(.headline)
                    Text(slideVm.flightInfo.schedDeparture)
                    Text(slideVm.flightInfo.departureDate)
                }
                Spacer()
            }
            HStack{
                Spacer()
                VStack(alignment: .trailing){
                    Text(slideVm.flightInfo.destinationCity)
                        .font(.headline)
                    Text(slideVm.flightInfo.schedArrival)
                    Text(slideVm.flightInfo.arrivalDate)
                }
            }
        }
        .foregroundStyle(.primary)
        .font(.callout)
        .padding()
    }
    
    
    // Loading view - Shimmer rect
    func shimmerRect(radius: CGFloat, w: CGFloat?, h: CGFloat?) -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: radius)
                .frame(width: w, height: h)
                .foregroundStyle(.shimmerGray)
                .shimmering(bandSize: 1)
        }
    }
    
    // Loading view - Shimmer schedule
    func shimmerSched(alignment: HorizontalAlignment) -> some View{
        VStack(alignment: alignment){
            shimmerRect(radius: 5, w: 90, h: 15)
            shimmerRect(radius: 5, w: 120, h: 15)
            shimmerRect(radius: 5, w: 190, h: 15)
        }
    }
}
