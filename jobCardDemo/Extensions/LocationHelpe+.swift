//
//  LocationHelper.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()
    var locationUpdated: ((_ lat: Double, _ long: Double, _ address: String?) -> ())?
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    func getCurrentUserLocation() {
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        getAddressOfLocation(lat: location.coordinate.latitude, lng: location.coordinate.longitude) { locationAddress in
            self.locationUpdated?(location.coordinate.latitude, location.coordinate.longitude, locationAddress)
            self.stopUpdatingLocation()
        }
    }
    func getAddressOfLocation(lat: Double?, lng: Double?, compilation: @escaping (String?) -> ()) {
        guard let _lat = lat, let _lng = lng else {return}
        let location = CLLocation(latitude: _lat, longitude: _lng)
        CLGeocoder().reverseGeocodeLocation(location) { (placeMarks, error) in
            if error != nil {
                print(error ?? "Unknown Error")
            } else {
                
                guard let placeMarks = placeMarks?.first else {return}
                let streetName = placeMarks.thoroughfare ?? ""
                let area = placeMarks.administrativeArea ?? ""
                let locality =  placeMarks.locality ?? ""
                let address = (streetName + " " + locality + " "  + area)
                compilation(address)
            }
        }
    }
}
