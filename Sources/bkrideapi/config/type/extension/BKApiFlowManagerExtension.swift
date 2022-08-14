//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import ghmjolnircore
import bksdkcore

extension BKApiFlow: GHManagerModelDelegate {
    public func getController() -> GHBaseViewControllerDelegate? {
        switch self {
            case .currentRide:
                return BKCurrentRadeViewController.instantiate(
                    fromStoryboard: self.getStoryboard(),
                    bundle: .module
                )
            case .myProgress:
                return BKMyProgressViewController.instantiate(
                    fromStoryboard: self.getStoryboard(),
                    bundle: .module
                )
            case .detailProgress:
                return BKDetailProgressViewController.instantiate(
                    fromStoryboard: self.getStoryboard(),
                    bundle: .module
                )
            default:
                return nil
        }
    }
    
    public func getViewModel() -> GHBaseViewModelProtocol? {
        switch self {
        case .currentRide, .myProgress, .detailProgress:
                return BKRideViewModel()
            default:
                return nil
        }
    }
    
    func getStoryboard() -> String {
        return "BKRide"
    }
}
