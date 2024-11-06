//
//  Flight_SpyApp.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 24/09/2024.
//

import SwiftUI

@main
struct Flight_SpyApp: App {
    @StateObject private var acData = AircaftInfoDataService()
    @StateObject private var mainVm = MainViewModel()
    @StateObject private var slideVm = SlideFlightInfoViewModel()
    @State var showLunchView: Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack{
                MainView()
                    .zIndex(1)
                    .environmentObject(acData)
                    .environmentObject(mainVm)
                    .environmentObject(slideVm)
                    .environment(\.sizeCategory, .large)
                if showLunchView{
                    LunchView(showLunchView: $showLunchView)
                        .zIndex(2)
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.linear, value: !showLunchView)
        }
    }
}



