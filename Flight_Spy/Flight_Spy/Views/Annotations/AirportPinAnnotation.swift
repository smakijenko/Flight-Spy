//
//  AirportPinAnnotation.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 05/11/2024.
//

import SwiftUI

struct AirportPinAnnotation: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Image(colorScheme == .dark ? "airportPinIconWhite" : "airportPinIconBlack")
            .resizable()
            .frame(width: 10, height: 10)
    }
}

#Preview {
    AirportPinAnnotation()
}
