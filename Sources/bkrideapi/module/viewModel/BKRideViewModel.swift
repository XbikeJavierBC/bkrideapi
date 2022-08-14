//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation
import ghmjolnircore

public class BKRideViewModel: BKRideViewModelProtocol {
    public lazy var errorLiveData: GHLiveData<(id: Any, error: Error)?> = GHLiveData(nil)
    
    public func removeReferenceContext() {
        
    }
}
