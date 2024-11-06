//
//  CountryPickerView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 13/10/2024.
//

import SwiftUI
struct CountryPickerView: View {
    @EnvironmentObject private var mainVm: MainViewModel
    var body: some View {
        VStack{
            if mainVm.showRegionsList{
                regionsList
            }
            Button {
                mainVm.toggleRegionsList()
            } label: {
                buttonLabel
            }
        }
        .foregroundStyle(Color.primary)
        .fontWeight(.bold)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding()
    }
}

#Preview {
    CountryPickerView()
        .environmentObject(MainViewModel())
}

extension CountryPickerView{
    private var regionsList: some View{
        VStack {
            List {
                ForEach(mainVm.regions) { region in
                    Button {
                        mainVm.setRegionSettings(region: region)
                    } label: {
                        HStack {
                            Image(region.coutryName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 43)
                            Text(region.coutryName)
                                .foregroundColor(.primary)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 250)
    }
    
    private var buttonLabel: some View{
        Text(mainVm.regionText)
            .font(.title2)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .animation(.none, value: mainVm.showRegionsList)
            .overlay(alignment: .leading) {
                Image(systemName: "arrow.up")
                    .font(.title3)
                    .padding()
                    .rotationEffect(Angle.degrees(mainVm.showRegionsList ? 180 : 0))
            }
    }
}
