//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import bksdkcore

extension BKCurrentRadeViewController {
    func setupBinds() {
        self.rideViewModel?.errorLiveData.bind { [weak self] errorTuple in
            guard let self = self, let error = errorTuple?.error else { return }
            
            BKAlertController.error(
                message: error.localizedDescription,
                controller: self
            )
        }
        
        self.rideViewModel?.coordinateLiveData.bind { [weak self] coordinate in
            guard let self = self, let coordinate = coordinate,
                    let trackRoute = self.rideViewModel?.trackRouteLiveData.value, trackRoute else { return }
            
            self.rideViewModel?.appendMetersToRoute(location: coordinate)
            self.rideViewModel?.coordinateListLiveData.value.append(coordinate)
            self.drawPolyline(coordinate: coordinate)
        }
        
        self.rideViewModel?.saveDataSuccessLiveData.bind { [weak self] opt in
            guard let self = self, let opt = opt else { return }
            
            if opt {
                self.simplePopUpView.show()
            }
        }
    }
}
