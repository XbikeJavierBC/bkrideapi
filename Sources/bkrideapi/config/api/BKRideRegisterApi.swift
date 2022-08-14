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
        let currentRideType = BKApiFlow.currentRide
        let myProgressType  = BKApiFlow.myProgress
        
        return [
            GHManagerModelBuilder()
                .withType(type: currentRideType.rawValue)
                .withDelegate(delegate: currentRideType)
                .withBundle(bundle: .module)
                .build(),
            GHManagerModelBuilder()
                .withType(type: myProgressType.rawValue)
                .withDelegate(delegate: myProgressType)
                .withBundle(bundle: .module)
                .build()
        ]
    }()
}
