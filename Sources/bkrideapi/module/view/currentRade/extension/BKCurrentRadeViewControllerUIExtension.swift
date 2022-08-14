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
        self.setupTimerView()
    }
    
    func updateUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setDarkBackStyle(
            color: .white,
            font: .abelRegular20
        )
    }
    
    func setupTimerView() {
        let timerView = BKTimerView()
        timerView.delegate = self
        self.containerView.addSubview(timerView)
        
        timerView.width(260)
        timerView.height(148)
        
        timerView.bottom(to: self.containerView, .none, offset: -24, relation: .equal, priority: .defaultHigh, isActive: true)
        timerView.centerX(to: self.containerView)
    }
}

extension BKCurrentRadeViewController: BKValidateUIProtocol {
    public func validateUI() {
        self.mapsManaget?.requestLocationPermision()
    }
}
