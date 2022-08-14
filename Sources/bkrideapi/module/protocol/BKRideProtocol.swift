//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import ghmjolnircore

public protocol BKRideViewModelProtocol: GHBaseViewModelProtocol {
    var errorLiveData: GHLiveData<(id: Any, error: Error)?> { get set }
}

public protocol BKRideCoordinatorProtocol: GHBaseCoordinatorProtocol {
    
}
