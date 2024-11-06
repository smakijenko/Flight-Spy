//
//  AircraftLocationAnnotation.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 09/10/2024.
//

import SwiftUI

struct AircraftLocationAnnotation: View {
    var acTrack: Double
    var onGround: Bool
    var body: some View {
        if acTrack != 361 {
            AircraftAnnotation
        }
        else {NoTrackAnnotation}
    }
}

#Preview {
    AircraftLocationAnnotation(acTrack: 0, onGround: false)
}

extension AircraftLocationAnnotation{
    private var AircraftAnnotation: some View{
        if onGround{
            Image("acAnnNoShad")
                .resizable()
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: acTrack))
        }
        else{
            Image("acAnnShad")
                .resizable()
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: acTrack))
        }
    }
    
    private var NoTrackAnnotation: some View{
        ZStack{
            Image(systemName: "airplane.circle.fill")
                .font(.title2)
                .foregroundStyle(.yellow)
                .rotationEffect(Angle(degrees: 180))
            Image(systemName: "questionmark")
                .font(.headline)
        }
    }
}

