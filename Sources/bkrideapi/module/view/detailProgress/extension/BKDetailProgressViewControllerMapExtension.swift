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
import bkdomauncore

extension BKDetailProgressViewController {
    internal func setupMaps() {
        self.myMapView.settings.compassButton = true
        self.myMapView.settings.myLocationButton = false
        self.myMapView.isMyLocationEnabled = false
        
        self.containerView.addSubview(self.myMapView)
        self.myMapView.edgesToSuperview()
    }
    
    func drawPolyline(coordinateList: [CLLocationCoordinate2D], model: BKRideModel) {
        coordinateList.forEach { location in
            self.mutablePath.add(location)
        }
        
        self.polyline.path = self.mutablePath
        
        if self.polyline.map == nil {
            self.polyline.map = self.myMapView
        }
        
        let bounds = GMSCoordinateBounds(path: self.mutablePath)
        let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
        self.myMapView.moveCamera(update)
        
        self.addMyLocationMarket(
            coordinate: self.mutablePath.coordinate(at: 0),
            title: model.startAddress,
            image: GMSMarker.markerImage(
                with: .oragenColor
            )
        )
        
        let coordinate = self.mutablePath.count() == 0
                ? self.mutablePath.coordinate(at: 0)
                : self.mutablePath.coordinate(at: self.mutablePath.count() - 1)
        
        self.addMyLocationMarket(
            coordinate: coordinate,
            title: model.endAddress,
            image: GMSMarker.markerImage(
                with: .green
            )
        )
    }
    
    internal func addMyLocationMarket(coordinate: CLLocationCoordinate2D, title: String, image: UIImage?) {
        let myLocationMarker = GMSMarker(
            position: coordinate
        )
        myLocationMarker.title = title
        myLocationMarker.icon = image
        myLocationMarker.map = self.myMapView
    }
}
