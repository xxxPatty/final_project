//
//  MapAppDelegate.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/3.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("Your API Key")
        GMSPlacesClient.provideAPIKey("Your API Key")
        return true
    }
}
