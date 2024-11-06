//
//  PulsatorView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 02/10/2024.
//

import SwiftUI

struct PulsatorView: View {
    @EnvironmentObject private var mainVm: MainViewModel
    @EnvironmentObject private var acData: AircaftInfoDataService
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let duration: Double = 1

    var body: some View {
        VStack(spacing: 0){
            Button {
                mainVm.toggleIntervalList()
            } label: {
                pulsingCircles
            }
            if mainVm.showIntervalList {
                intervals
            }
            
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .frame(maxWidth: 60)
        .shadow(radius: 3)
        .padding()
        .onReceive(timer) { _ in
            refresh()
        }
    }
}

#Preview {
    PulsatorView()
        .environmentObject(MainViewModel())
        .environmentObject(AircaftInfoDataService())
}

extension PulsatorView {
    private var pulsingCircles: some View {
        ZStack{
            Circle()
                .fill(mainVm.isRefreshing ? Color.green : Color.red)
                .frame(width: 15)
            Circle()
                .fill(mainVm.isRefreshing ? Color.green : Color.red).opacity(0.15)
                .frame(width: 55)
                .scaleEffect(acData.pulstatorAnimating ? 1 : 0)
            Circle()
                .fill(mainVm.isRefreshing ? Color.green : Color.red).opacity(0.25)
                .frame(width: 50)
                .scaleEffect(acData.pulstatorAnimating ? 1 : 0)
            Circle()
                .fill(mainVm.isRefreshing ? Color.green : Color.red).opacity(0.35)
                .frame(width: 40)
                .scaleEffect(acData.pulstatorAnimating ? 1 : 0)
            Circle()
                .fill(mainVm.isRefreshing ? Color.green : Color.red).opacity(0.45)
                .frame(width: 30)
                .scaleEffect(acData.pulstatorAnimating ? 1 : 0)
        }
        .animation(.easeOut(duration: duration), value: acData.pulstatorAnimating)
    }
    
    private var intervals: some View {
        VStack(spacing: 10){
            ForEach(0 ..< mainVm.intervals.count, id: \.self) { index in
                Button {
                    mainVm.chooseInterval(inInterval: mainVm.intervals[index])
                } label: {
                    Text("\(mainVm.intervals[index])s")
                        .foregroundStyle(Color.primary)
                        .font(.title2)
                        .fontWeight(.medium)
                        .underline(mainVm.intervals[index] == mainVm.interval ? true : false)
                }
            }
        }
        .frame(height: 170)
    }
    
    func refresh() {
        if mainVm.isRefreshing && !acData.showAircraftsAlert{
            if mainVm.counter == mainVm.interval{
                acData.getAicrafts(region: mainVm.apiRegionString)
                mainVm.counter = 0
            }
            mainVm.counter += 1
        }
        else {mainVm.counter = mainVm.interval}
    }
}
