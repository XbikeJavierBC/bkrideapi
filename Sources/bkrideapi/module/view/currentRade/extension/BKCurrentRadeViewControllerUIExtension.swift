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

extension BKCurrentRadeViewController {
    func setupUI() {
        self.title = BKRideLocalization.currentRide.localize
        self.addNavImageButtonLeft(imageLeft: nil)
        self.addNavImageButtonRight(
            image: UIImage(
                systemName: "plus"
            )
        )
        
        self.setupMapManager()
    }
    
    func updateUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setDarkBackStyle(
            color: .white,
            font: .abelRegular20
        )
    }
}

extension BKCurrentRadeViewController: BKValidateUIProtocol {
    public func validateUI() {
        self.mapsManaget?.requestLocationPermision()
    }
}
