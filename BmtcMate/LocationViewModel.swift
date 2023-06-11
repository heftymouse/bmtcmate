//
//  LocationViewModel.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import Foundation
import CoreLocation
import SwiftUI
import WidgetKit

public class LocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation? = nil
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
    
    public func authorizedForWidgetUpdates() -> Bool {
        return locationManager.isAuthorizedForWidgetUpdates
    }
    
    public func getNewLocation(handler: @escaping (CLLocation) -> Void) {
        
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
