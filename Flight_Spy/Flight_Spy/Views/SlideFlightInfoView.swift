//
//  SlideFlightInfoView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 19/10/2024.
//

import SwiftUI
import Shimmer

struct SlideFlightInfoView: View {
    @EnvironmentObject var slideVm: SlideFlightInfoViewModel
    @Environment(\.colorScheme) var colorScheme
    var invertedColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var body: some View {
        ZStack{
            if slideVm.isDataLoaded{
                loadedView
            }
            else{
                loadingView
            }
        }
        
        .clipShape(.rect(bottomTrailingRadius: 10, topTrailingRadius: 10))
        .shadow(radius: 5)
        .frame(maxWidth: 310, maxHeight: 600)
        .scaleEffect(slideVm.scale, anchor: .leading)
        .offset(x: slideVm.isOut ? 310 * -slideVm.scale * 1.1 : slideVm.offset)
        .gesture(slideGesture())
        .onAppear(perform: fetchFlightInfo)
    }
}

#Preview {
    SlideFlightInfoView()
        .environmentObject(SlideFlightInfoViewModel())
}

extension SlideFlightInfoView {
    
    // On appear fetching func
    private func fetchFlightInfo(){
        if let flightCode = slideVm.acInfo?.callsign {
            Task {
                if let fetchedFlightInfo = await FlightInfoDataService().fetchFlightInfo(flightCode: flightCode){
                    if slideVm.checkFlightInfo(info: fetchedFlightInfo){
                        slideVm.showLoadedFlightInfo(info: fetchedFlightInfo)
                    }
                }
                else{
                    slideVm.showSlideInfoAlert.toggle()
                }
            }
        }
    }
    
    // Sliding func
    func slideGesture() -> some Gesture{
        DragGesture()
            .onChanged { gesture in
                if gesture.translation.width < 0{
                    slideVm.offset = gesture.translation.width
                }
            }
            .onEnded { _ in
                withAnimation(.linear(duration: 0.2)){
                    if abs(slideVm.offset) > 80 && !slideVm.isPathShown{
                        slideVm.closeSlideFlightInfoView()
                    }
                    else{
                        slideVm.offset = 0
                        slideVm.closePath()
                    }
                }
            }
    }
    
    // Menu bar
    var menuBar: some View {
        HStack(spacing: 2){
            Button {
                slideVm.toogleAcInfo()
            } label: {
                Rectangle()
                    .foregroundStyle(.barGrey)
                    .clipShape(.rect(topLeadingRadius: 20, bottomLeadingRadius: 20))
                    .padding(.leading)
                    .overlay(alignment: .center){
                        Image(systemName: "list.bullet")
                            .offset(x: 11)
                    }
            }
            Button {
                slideVm.showPath()
            } label: {
                Rectangle()
                    .foregroundStyle(.barGrey)
                    .clipShape(.rect(bottomTrailingRadius: 20, topTrailingRadius: 20))
                    .padding(.trailing)
                    .overlay(alignment: .center){
                        Image(systemName: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                            .offset(x: -11)
                    }
            }
        }
        .foregroundStyle(.primary)
        .font(.title3)
        .fontWeight(.medium)
        .frame(height: 45)
        .padding(.vertical)
    }
    
    // Loaded view
    private var loadedView: some View {
        ZStack{
            background
            VStack(spacing: 0){
                if slideVm.isPathShown{
                    pathButton
                }
                aircraftImage
                airlineName
                progressBar
                if slideVm.isAcInfoOpen{
                    acInfo
                        .transition(.slide)
                }
                else{
                    schedules
                        .transition(.slide)
                    
                }
                Spacer()
                menuBar
            }
        }
    }
    
    // Loading view
    private var loadingView: some View {
        ZStack{
            background
            VStack{
                VStack(spacing: 0){
                    shimmerRect(radius: 10, w: nil, h: 180)
                        .padding()
                    shimmerRect(radius: 5, w: 130, h: 17)
                    HStack {
                        Image(systemName: "airplane.departure")
                        shimmerRect(radius: 5, w: nil, h: 7)
                            .padding(.vertical, 12)
                        Image(systemName: "airplane.arrival")
                    }
                    .font(.title2)
                    .padding(.horizontal)
                    VStack{
                        HStack{
                            shimmerSched(alignment: .leading)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                            shimmerSched(alignment: .trailing)
                        }
                    }
                    .padding()
                }
                .foregroundStyle(.shimmerGray)
                .shimmering(bandSize: 1)
                Spacer()
                menuBar
            }
        }
    }
}
