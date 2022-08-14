//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import Foundation

public enum BKRideLocalization: String {
    case extremelySimple
   
    public var localize: String {
        self.localizedString(
            key: self
        )
    }

    private func localizedString(key: BKRideLocalization) -> String {
        NSLocalizedString(
            key.rawValue,
            tableName: "bkrideapi",
            bundle: .module,
            comment: key.rawValue
        )
    }
}
