//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import TinyConstraints

import ghmjolnircore
import bksdkcore

extension BKMyProgressViewController {
    func setupBinds() {
        self.rideViewModel?.errorLiveData.bind { [weak self] errorTuple in
            guard let self = self, let error = errorTuple?.error else { return }
            
            BKAlertController.error(
                message: error.localizedDescription,
                controller: self
            )
        }
        
        self.rideViewModel?.rideModelLiveData.bind { [weak self] list in
            guard let self = self, let list = list else { return }
            
            if list.isEmpty {
                self.containerView.addSubview(self.emptyProgressView)
                self.emptyProgressView.edgesToSuperview()
            }
            else {
                if self.emptyProgressView.isDescendant(of: self.containerView) {
                    self.emptyProgressView.removeFromSuperview()
                }
                
                self.strategyList.setSource(listSource: list)
                
                if !self.strategyList.tableView.isDescendant(of: self.containerView) {
                    self.containerView.addSubview(self.strategyList.tableView)
                    self.strategyList.tableView.edgesToSuperview()
                    self.strategyList.delegate = self
                }
            }
        }
    }
}
