//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

import bksdkcore
import bkdomauncore

extension BKDetailProgressViewController {
    func setupUI() {
        self.title = BKRideLocalization.detailProgress.localize
        self.addNavImageButtonLeft(
            imageLeft: UIImage(systemName: "arrow.left")
        )
        self.setupMaps()
        
        if let model: BKRideModel = self.bundle?.get("bk_detail_progress_key") {
            self.drawPolyline(
                coordinateList: model.coordinateList.map {
                    CLLocationCoordinate2D(
                        latitude: $0.latitude,
                        longitude: $0.longitude
                    )
                },
                model: model
            )
        }
    }
    
    func updateUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setDarkBackStyle(
            color: .white,
            font: .abelRegular20
        )
    }
}
