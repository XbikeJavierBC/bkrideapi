//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import TinyConstraints
import bksdkcore

extension BKCurrentRadeViewController: GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("Current location: <\(location.latitude), \(location.longitude)>")
    }
    
    internal func setupMaps() {
        self.myMapView.delegate = self
        self.myMapView.settings.compassButton = true
        self.myMapView.settings.myLocationButton = true
        self.myMapView.isMyLocationEnabled = true
        
        self.mapView.addSubview(self.myMapView)
        self.myMapView.edgesToSuperview()
        
        // Listen to the myLocation property of GMSMapView.
        self.observation = self.myMapView.observe(\.myLocation, options: [.new]) { [weak self] map, _ in
            guard let self = self else { return }
            self.location = map.myLocation
        }
    }
    
    func setupMapManager() {
        self.mapsManaget = BKMapsManager(
            mapView: self.myMapView
        )
        self.mapsManaget?.delegate = self
        self.mapsManaget?.requestLocationPermision()
    }
}

extension BKCurrentRadeViewController: SMMapsManagerDelegate {
    func accessLocation(status: Bool) {
        if status {
            if !self.myMapView.isDescendant(of: self.mapView) {
                self.setupMaps()
            }
        }
    }
    
    func showAppSettings() {
        BKAlertController.error(
            message: BKRideLocalization.noGeolocationAccess.localize,
            controller: self) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
    }
}
