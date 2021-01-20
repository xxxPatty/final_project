//
//  Map.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/3.
//

import GoogleMaps
import SwiftUI

class YourViewController: UIViewController {

  // You don't need to modify the default init(nibName:bundle:) method.
  @IBOutlet weak var mapView: GMSMapView!
  override func loadView() {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    mapView.camera = camera

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
  }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        YourViewController()
    }
}
