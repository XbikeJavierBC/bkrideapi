//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import GoogleMaps

import bksdkcore

//MARK: Timer View
extension BKCurrentRadeViewController: BKTimerViewDelegate {
    func didUpdateTime(time: Int) {
        self.rideViewModel?.timeInSecondsLiveData.value = time
    }
    
    func didStartSelect(view: BKTimerView) {
        guard let location = self.trackLocation else { return }
        
        self.rideViewModel?.trackRouteLiveData.value = true
        
        self.mapsManaget?.addMyLocationMarket(
            coordinate: location.coordinate
        )
    }
    
    func didStopSelect(view: BKTimerView) {
        view.removeFromSuperview()
        
        guard let location = self.trackLocation else { return }
        
        self.rideViewModel?.trackRouteLiveData.value = false
        
        self.mapsManaget?.addMyLocationMarket(
            coordinate: location.coordinate,
            image: GMSMarker.markerImage(
                with: .green
            )
        )
        
        self.mapsManaget?.getCurrentPlace(closure: { address in
            self.rideViewModel?.endAddressLiveData.value = address
            
            guard let vm = self.rideViewModel,
                    let distance = vm.distanceInMetersLiveData.value,
                        let seconds = vm.timeInSecondsLiveData.value else {
                return
            }
            
            DispatchQueue.main.async {
                self.yourTimeWasView.show(
                    distance: distance,
                    time: seconds
                )
            }
        })
    }
}

//MARK: Yout Time Was
extension BKCurrentRadeViewController: BKYourTimeWasViewDelegate {
    func didStoreSelect(view: BKYourTimeWasView) {
        view.hide()
        self.rideViewModel?.saveRideData()
    }
    
    func didDeleteSelect(view: BKYourTimeWasView) {
        view.hide()
        self.releaseTimerView()
        
        self.releasePolylineFromMap()
    }
}

extension BKCurrentRadeViewController: BKSimplePopUpViewDelegate {
    func didAceptSelect(view: BKSimplePopUpView) {
        view.hide()
        
        self.releaseTimerView()
        self.releasePolylineFromMap()
    }
}
