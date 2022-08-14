//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import GoogleMaps
import CoreLocation

import ghmjolnircore
import bkdomauncore

public protocol BKRideViewModelProtocol: GHBaseViewModelProtocol {
    var errorLiveData: GHLiveData<(id: Any, error: Error)?> { get set }
    var coordinateListLiveData: GHLiveData<[CLLocationCoordinate2D]> { get set }
    var coordinateLiveData: GHLiveData<CLLocationCoordinate2D?> { get set }
    var trackRouteLiveData: GHLiveData<Bool?> { get set }
    var distanceInMetersLiveData: GHLiveData<CLLocationDistance?> { get set }
    var timeInSecondsLiveData: GHLiveData<Int?> { get set }
    var startAddressLiveData: GHLiveData<String?> { get set }
    var endAddressLiveData: GHLiveData<String?> { get set }
    var saveDataSuccessLiveData: GHLiveData<Bool?> { get set }
    var rideModelLiveData: GHLiveData<[BKRideModel]?> { get set }
    
    func appendMetersToRoute(location: CLLocationCoordinate2D)
    func saveRideData()
    func fetchRideDataList()
}

public protocol BKRideCoordinatorProtocol: GHBaseCoordinatorProtocol {
    
}
