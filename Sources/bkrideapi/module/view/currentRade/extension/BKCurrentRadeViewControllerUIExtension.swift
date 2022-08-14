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
    
    func setupTimerView() {
        if self.timerView == nil {
            self.timerView = BKTimerView()
            self.timerView?.delegate = self
        }
        
        if !self.timerView!.isDescendant(of: containerView) {
            self.containerView.addSubview(self.timerView!)
            
            self.timerView?.width(260)
            self.timerView?.height(148)
            
            self.timerView?.bottom(to: self.containerView, .none, offset: -24, relation: .equal, priority: .defaultHigh, isActive: true)
            self.timerView?.centerX(to: self.containerView)
        }
    }
    
    func releaseTimerView() {
        self.timerView?.removeFromSuperview()
        self.timerView = nil
    }
}

extension BKCurrentRadeViewController: BKValidateUIProtocol {
    public func validateUI() {
        self.mapsManaget?.requestLocationPermision()
    }
}
