//
//  LunchView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 05/10/2024.
//

import SwiftUI

struct LunchView: View {
    @State private var showZoomAnimation: Bool = false
    @State private var showFlightAnimation: Bool = false
    @State private var showPlane: Bool = true
    @Binding var showLunchView: Bool
    private let zoomDuration: Double = 0.3
    private let flightDuration: Double = 1
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
                ZStack{
                    Image("LoupeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("PlaneIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(
                            x: showFlightAnimation ? 170 : 0,
                            y: showFlightAnimation ? -154 : 0)
                        .opacity(showPlane ? 1 : 0)
                }
                .scaleEffect(showZoomAnimation ? 1.4 : 1)
        }
        .ignoresSafeArea()
        .onAppear{
            handleAnimation()
        }
    }
}

#Preview {
    LunchView(showLunchView: .constant(true))
}

extension LunchView {
    func handleAnimation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            withAnimation(.easeIn(duration: zoomDuration)){
                showZoomAnimation.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + zoomDuration){
            withAnimation(.linear(duration: flightDuration)){
                showFlightAnimation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + flightDuration){
                    showPlane = false
                    showLunchView = false
                }
            }
        }
    }
}
