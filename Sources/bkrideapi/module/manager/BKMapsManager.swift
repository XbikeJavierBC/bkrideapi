//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import GoogleMaps
import GooglePlaces
import CoreLocation

import bksdkcore

protocol SMMapsManagerDelegate {
    func accessLocation(status: Bool)
    func showAppSettings()
}

class BKMapsManager: NSObject {
    private var placesClient: GMSPlacesClient!
    private var currentCoordinate: CLLocationCoordinate2D!
    
    private var myMapView: GMSMapView!
    private var locationManager: CLLocationManager?
    
    internal var delegate: SMMapsManagerDelegate?
    
    init(mapView: GMSMapView) {
        super.init()
        
        self.myMapView = mapView
        
        self.placesClient = GMSPlacesClient.shared()
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
    }
    
    func requestLocationPermision() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    print("Request Access")
                    self.locationManager?.requestLocation()
                case .restricted, .denied:
                    print("No access")
                    self.delegate?.showAppSettings()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    self.delegate?.accessLocation(status: true)
                @unknown default:
                    self.delegate?.showAppSettings()
            }
        }
        else {
            print("Location services are not enabled")
            self.delegate?.showAppSettings()
        }
    }
    
    func setDefaultSearchNearStores(coordinate: CLLocationCoordinate2D, closure: @escaping (String) -> ()) {
        self.addMyLocationMarket(coordinate: coordinate)
        self.getCurrentPlace(closure: closure)
    }
    
    internal func addMyLocationMarket(coordinate: CLLocationCoordinate2D, title: String = "Mi ubicación") {
        let myLocationMarker = GMSMarker(
            position: coordinate
        )
        myLocationMarker.title = title
        myLocationMarker.icon = GMSMarker.markerImage(
            with: .oragenColor
        )
        myLocationMarker.map = self.myMapView
    }
    
    private func getCurrentPlace(closure: @escaping (String) -> ()) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        
        self.placesClient?.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
            guard self != nil else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                closure("No current place")
                return
            }
            
            guard let place = placeLikelihoods?.first?.place else {
                closure("No current place")
                return
            }
            
            closure(place.formattedAddress ?? "")
        }
    }
    
    func moveCustomLocation(coordinate: CLLocationCoordinate2D) {
        self.myMapView.camera = GMSCameraPosition.camera(
            withLatitude: coordinate.latitude,
            longitude: coordinate.longitude,
            zoom: self.myMapView.camera.zoom
        )
    }
}

extension BKMapsManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                print("Request access")
                self.locationManager?.requestAlwaysAuthorization()
            case .restricted, .denied:
                print("No access")
                self.delegate?.showAppSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                self.delegate?.accessLocation(status: true)
            @unknown default:
                self.delegate?.showAppSettings()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        dump(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
        dump(error.localizedDescription)
    }
}
