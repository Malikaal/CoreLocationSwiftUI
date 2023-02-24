//
//  ContentView.swift
//  CoreLocationSwiftUI
//
//  Created by Malik A. Aziz Lubis on 25/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    
    var body: some View {
        VStack {
            VStack {
                switch locationDataManager.locationManager.authorizationStatus {
                case .authorizedWhenInUse:  // Location services are available.
                    // Insert code here of what should happen when Location services are authorized
                    Text("Your current location is:")
                    Text("Latitude: \(locationDataManager.latitude)")
                    Text("Longitude: \(locationDataManager.longitude)")
                    Text("Address: \(locationDataManager.address)")
                    Text("City: \(locationDataManager.city)")
                    Text("State: \(locationDataManager.state)")
                    Text("Zip Code: \(locationDataManager.zip)")
                    Text("Contry: \(locationDataManager.country)")
                    
                case .restricted, .denied:  // Location services currently unavailable.
                    // Insert code here of what should happen when Location services are NOT authorized
                    Text("Current location data was restricted or denied.")
                case .notDetermined:        // Authorization not determined yet.
                    Text("Finding your location...")
                    ProgressView()
                default:
                    ProgressView()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
