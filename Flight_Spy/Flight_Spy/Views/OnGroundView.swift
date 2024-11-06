//
//  OnGroundView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 11/10/2024.
//

import SwiftUI

struct OnGroundView: View {
    @EnvironmentObject private var acData: AircaftInfoDataService
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Button {
            acData.showOnGround.toggle()
        } label: {
            ZStack{
                buttonBg
                    .overlay {
                        if acData.showOnGround {onGround}
                        else {inAir}
                    }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    OnGroundView()
        .environmentObject(AircaftInfoDataService())
}

extension OnGroundView {
    private var buttonBg: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: 60, maxHeight: 60)
            .foregroundStyle(.ultraThinMaterial)
            .shadow(radius: 3)
    }
    
    private var inAir: some View {
        Image(systemName: "airplane.departure")
            .foregroundStyle(Color.primary)
            .font(.title)
    }
    
    private var onGround: some View {
        Image(colorScheme == .dark ? "OnGroundWhite" : "OnGroundBlack")
            .resizable()
            .frame(maxWidth: 45, maxHeight: 45)
    }
}
