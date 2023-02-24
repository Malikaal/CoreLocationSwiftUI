//
//  LoactionDataManager.swift
//  CoreLocationSwiftUI
//
//  Created by Malik A. Aziz Lubis on 25/02/23.
//

import Foundation
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var address: String = ""
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var zip: String = ""
    @Published var country: String = ""
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
        guard let location = locations.last else { return }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        
        print("Latitude: \(latitude)")
        print("Longitude: \(longitude)")
        
        let geocoder = CLGeocoder()
        let myLocation = CLLocation(latitude: latitude, longitude: longitude)

        geocoder.reverseGeocodeLocation(myLocation) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("Cannot find your location!")
                return
            }

            // Access the address properties of the placemark
            let address = placemark.name ?? "1"
            let city = placemark.locality ?? "2"
            let state = placemark.administrativeArea ?? "3"
            let zip = placemark.postalCode ?? "4"
            let country = placemark.country ?? "5"
            self.address = placemark.name ?? "Address Not Found"
            self.city = placemark.locality ?? "City Not Found"
            self.state = placemark.administrativeArea ?? "State Not Found"
            self.zip = placemark.postalCode ?? "Zip Code Not Found"
            self.country = placemark.country ?? "Country Not Found"
            
            // Use the address properties as needed
            print("\(address), \(city), \(state) \(zip), \(country)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
