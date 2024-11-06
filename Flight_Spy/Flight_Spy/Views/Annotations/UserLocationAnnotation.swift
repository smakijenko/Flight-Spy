//
//  UserLocationAnnotation.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 04/10/2024.
//

import SwiftUI

struct UserLocationAnnotation: View {
    @State private var isUserIconAnimating = false
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.white)
                .frame(width: 22)
            Circle()
                .fill(Color.blue)
                .frame(width: 15)
                .scaleEffect(isUserIconAnimating ? 0.85 : 1)
        }
        .onAppear(perform: {
            isUserIconAnimating = true
        })
        .animation(.linear(duration: 1).delay(0.75).repeatForever(), value: isUserIconAnimating)
    }
}

#Preview {
    UserLocationAnnotation()
}
