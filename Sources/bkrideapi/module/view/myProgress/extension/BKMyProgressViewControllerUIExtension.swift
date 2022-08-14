//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import bksdkcore

extension BKMyProgressViewController {
    func setupUI() {
        self.title = BKRideLocalization.myProgress.localize
        self.addNavImageButtonLeft(imageLeft: nil)
    }
    
    func updateUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setDarkBackStyle(
            color: .white,
            font: .abelRegular20
        )
    }
}
