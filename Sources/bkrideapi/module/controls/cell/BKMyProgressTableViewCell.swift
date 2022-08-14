//
//  BKMyProgressTableViewCell.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

import ghmjolnircore
import bkdomauncore
import bksdkcore

class BKMyProgressTableViewCell: UITableViewCell {
    @IBOutlet weak var rootView: UIView! {
        didSet {
            rootView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = .abelRegular30
            timeLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var distanceLabel: UILabel! {
        didSet {
            distanceLabel.font = .abelRegular25
            distanceLabel.textColor = .black
        }
    }
    
    @IBOutlet weak var aLabel: UILabel! {
        didSet {
            aLabel.font = .abelRegular15
            aLabel.textColor = .subtitleTextColor
            aLabel.text = "A."
        }
    }
    @IBOutlet weak var startAddressLabel: UILabel! {
        didSet {
            startAddressLabel.font = .abelRegular15
            startAddressLabel.textColor = .subtitleTextColor
        }
    }
    
    @IBOutlet weak var bLabel: UILabel! {
        didSet {
            bLabel.font = .abelRegular15
            bLabel.textColor = .subtitleTextColor
            bLabel.text = "B."
        }
    }
    @IBOutlet weak var endAddressLabel: UILabel! {
        didSet {
            endAddressLabel.font = .abelRegular15
            endAddressLabel.textColor = .subtitleTextColor
        }
    }
}

extension BKMyProgressTableViewCell: GHSimpleTableViewCellDelegate {
    func bind(model: GHModelSimpleTableDelegate) {
        guard let model = model as? BKRideModel else {
            return
        }
        
        self.startAddressLabel.text = model.startAddress
        self.endAddressLabel.text = model.endAddress
        
        self.fillData(distance: model.distance, time: model.time)
        
        
    }
    
    private func hmsFrom(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    private func fillData(distance: Double, time: Int) {
        let (h,m,s) = self.hmsFrom(seconds: time)
        
        let hours   = self.getStringFrom(seconds: h)
        let minutes = self.getStringFrom(seconds: m)
        let seconds = self.getStringFrom(seconds: s)
        
        self.timeLabel.text = "\(hours) : \(minutes) : \(seconds)"
        
        let kilometers = distance * 0.001
        
        self.distanceLabel.text = String(format: "%.2f km", kilometers)
    }
}
