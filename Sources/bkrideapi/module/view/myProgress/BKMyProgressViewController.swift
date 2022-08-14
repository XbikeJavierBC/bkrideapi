//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit

import ghmjolnircore
import bksdkcore

class BKMyProgressViewController: BKBaseViewController {
    //MARK: IBOutlets
    @IBOutlet var rootView: UIView! {
        didSet {
            rootView.backgroundColor = .oragenColor
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .clear
        }
    }
    
    //MARK: Properties
    internal var rideViewModel: BKRideViewModelProtocol? {
        return self.viewModel as? BKRideViewModelProtocol
    }
    
    internal lazy var strategyList = GHStrategyTableController(
        nibList: [("BKMyProgressTableViewCell", .module)]
    )
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBinds()
        self.setupUI()
        
        self.rideViewModel?.fetchRideDataList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUI()
    }
}
