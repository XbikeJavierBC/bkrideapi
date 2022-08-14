//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import ghmjolnircore

extension BKMyProgressViewController: GHStrategyTableControllerDelegate {
    func itemSelected(model: GHModelSimpleTableDelegate) {
        BKOnBoardingCoordinator.goToDetailProgressFlow(
            manager: self.controllerManager,
            model: model
        )
    }
}
