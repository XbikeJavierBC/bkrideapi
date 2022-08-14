//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import GoogleMaps
import CoreLocation
import Combine

import ghmjolnircore

import bkdomauncore
import bklocalrepositorycore

public class BKRideViewModel: BKRideViewModelProtocol {
    public lazy var errorLiveData: GHLiveData<(id: Any, error: Error)?> = GHLiveData(nil)
    public lazy var coordinateListLiveData: GHLiveData<[CLLocationCoordinate2D]> = GHLiveData([])
    public lazy var coordinateLiveData: GHLiveData<CLLocationCoordinate2D?> = GHLiveData(nil)
    public lazy var trackRouteLiveData: GHLiveData<Bool?> = GHLiveData(nil)
    
    public lazy var distanceInMetersLiveData: GHLiveData<CLLocationDistance?> = GHLiveData(0)
    public lazy var timeInSecondsLiveData: GHLiveData<Int?> = GHLiveData(nil)
    public lazy var startAddressLiveData: GHLiveData<String?> = GHLiveData(nil)
    public lazy var endAddressLiveData: GHLiveData<String?> = GHLiveData(nil)
    
    public lazy var saveDataSuccessLiveData: GHLiveData<Bool?> = GHLiveData(nil)
    public lazy var rideModelLiveData: GHLiveData<[BKRideModel]?> = GHLiveData(nil)
    
    private var subscriber: AnyCancellable?
    
    public func appendMetersToRoute(location: CLLocationCoordinate2D) {
        guard let lastCoordinate = self.coordinateListLiveData.value.last, let distanceInMeters = self.distanceInMetersLiveData.value else {
            return
        }
        
        let newCoordinate = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let lasCoordinate = CLLocation(latitude: lastCoordinate.latitude, longitude: lastCoordinate.longitude)
                
        self.distanceInMetersLiveData.value = distanceInMeters + newCoordinate.distance(from: lasCoordinate)
    }
    
    public func saveRideData() {
        guard let distance = self.distanceInMetersLiveData.value,
              let time = self.timeInSecondsLiveData.value,
              let starAddress = self.startAddressLiveData.value,
              let endAddress = self.endAddressLiveData.value else {
            return
        }
        
        let model = BKRideModel(
            time: time,
            distance: distance,
            startAddress: starAddress,
            endAddress: endAddress,
            coordinateList: self.coordinateListLiveData.value.map {
                BKCoordinateModel(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
            }
        )
        
        self.subscriber = try? BKRXRideLocalRepository.save(model: model)?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let error):
                            self.errorLiveData.value = (-1, error)
                        case .finished:
                            break
                    }
                },
                receiveValue: { sucess in
                    self.saveDataSuccessLiveData.value = true
                }
            )
    }
    
    public func fetchRideDataList() {
        self.subscriber = try? BKRXRideLocalRepository.getAll()?
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let error):
                            self.errorLiveData.value = (-1, error)
                        case .finished:
                            break
                    }
                },
                receiveValue: { list in
                    self.rideModelLiveData.value = list
                }
            )
    }
    
    public func removeReferenceContext() {
        self.subscriber?.cancel()
        self.subscriber = nil
    }
}
