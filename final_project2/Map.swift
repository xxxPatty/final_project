//
//  Map.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/3.
//

import GoogleMaps
import SwiftUI
import GooglePlaces

struct MapView2: UIViewRepresentable {
    @ObservedObject var restaurantData=restaurantInfoData()

    func makeUIView(context: Self.Context) -> GMSMapView {
        
        let camera = GMSCameraPosition.camera(withLatitude: 25.1505, longitude: 121.7758, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        for restaurant in restaurantData.myrestaurantInfo {
            let marker : GMSMarker = GMSMarker()
            if(restaurant.position.lat != -1 && restaurant.position.lng != -1){
                if(restaurant.scores >= 8 ){
                    marker.icon = GMSMarker.markerImage(with: .blue)
                }else{
                    marker.icon = GMSMarker.markerImage(with: .black)
                }
                marker.position = CLLocationCoordinate2D(latitude: restaurant.position.lat , longitude: restaurant.position.lng )
                marker.title = restaurant.restaurantName
                //marker.snippet = "Welcome to \(restaurant.restaurantName ) \n Scores: \(restaurant.scores)"
                marker.snippet = "Scores: \(restaurant.scores)"
                marker.map = mapView
            }
        }
    }
}



