//
//  FindMeView.swift
//  Flight_Spy
//
//  Created by Stanisław Makijenko on 03/10/2024.
//

import SwiftUI

struct FindMeView: View {
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var mainVm: MainViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var showRegionAlert: Bool = false
    @State private var showSettingsAlert: Bool = false
    
    var body: some View {
        ZStack{
            Button {
                if locationManager.manager.authorizationStatus == .denied || locationManager.manager.authorizationStatus == .restricted{
                    showSettingsAlert.toggle()
                }
                else{
                    mainVm.centerUser(locationManager: locationManager)
                    if !mainVm.checkUserRegion(){
                        showRegionAlert.toggle()
                    }
                }
            } label: {
                buttonLabel
            }
        }
        .padding()
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
        .alert("You are not in the supported region.", isPresented: $showRegionAlert) {}
        .alert(isPresented: $showSettingsAlert) {
            Alert (
                title: Text("To find your location, enable location services."),
                message: Text("Go to Settings?"),
                primaryButton: .default(Text("Settings"), action: {
                    openSettings()
                }),
                secondaryButton: .default(Text("Cancel")))
        }
    }
}

#Preview {
    FindMeView()
        .environmentObject(MainViewModel())
}

extension FindMeView {
    private func openSettings() {
        openURL(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    private var buttonLabel: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 60, height: 60)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 3)
            Image(systemName: "location.circle.fill")
                .foregroundStyle(Color.primary)
                .font(.title)
        }
    }
}
