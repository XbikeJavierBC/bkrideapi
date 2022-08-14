//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import bksdkcore
import ghmjolnircore

public struct BKOnBoardingCoordinator: BKRideCoordinatorProtocol {
    public static func goToDetailProgressFlow(manager: GHManagerController?, model: GHModelSimpleTableDelegate) {
        let parameters = GHBundleParameters()
        parameters.add(model, key: "bk_detail_progress_key")
        
        manager?.presentNavigationViewController(
            managerModel: try! BKApiFlow.detailProgress.modelManager,
            parameters: parameters
        )
    }
}
