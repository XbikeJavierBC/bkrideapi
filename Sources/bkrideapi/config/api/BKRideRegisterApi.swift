//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import ghmjolnircore
import bksdkcore

public class BKRideRegisterApi: BKSdkApiManagerProtocol {
    public static var flows: [GHManagerModel] = {
        let onBoardingType = BKApiFlow.onboarding
        
        return [
            GHManagerModelBuilder()
                .withType(type: onBoardingType.rawValue)
                .withDelegate(delegate: onBoardingType)
                .withBundle(bundle: .module)
                .build()
        ]
    }()
}
