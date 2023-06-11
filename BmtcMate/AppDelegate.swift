//
//  AppDelegate.swift
//  BmtcMate
//
//  Created by Vasu Deshpande on 11/06/23.
//

import UIKit
import CoreLocation

class AppDelegate: NSObject, UIApplicationDelegate, CLLocationManagerDelegate {
    static var locationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(getNearestStation(12.928645, 77.693063).value)
        return true
    }
}
