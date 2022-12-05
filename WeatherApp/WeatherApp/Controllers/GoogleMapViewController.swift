//
//  GoogleMapViewController.swift
//  WeatherApp
//
//  Created by Viktor on 02.12.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class GoogleMapViewController: UIViewController {
    
    var location: CLLocationManager!
    var currentPosition = CLLocationCoordinate2D()
    var mapView: GMSMapView!
    let marker = GMSMarker()
    var coordinates: ((CLLocationCoordinate2D)-> Void) = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location = CLLocationManager()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: currentPosition.latitude, longitude: currentPosition.longitude, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension GoogleMapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude, zoom: 10.0)
        
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                 longitude: location.coordinate.longitude)
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                 longitude: coordinate.longitude)
        marker.map = mapView
        coordinates(coordinate)
    }
}
