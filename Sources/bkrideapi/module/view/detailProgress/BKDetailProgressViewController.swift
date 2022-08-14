//
//  File.swift
//  
//
//  Created by Javier Carapia on 14/08/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

import bksdkcore

class BKDetailProgressViewController: BKBaseViewController {
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
    
    internal lazy var mutablePath = GMSMutablePath()
    
    internal lazy var myMapView: GMSMapView = {
        let camera = GMSCameraPosition(
            latitude: -33.868,
            longitude: 151.2086,
            zoom: 17
        )
        
        return GMSMapView(frame: .zero, camera: camera)
    }()
    
    internal lazy var polyline: GMSPolyline = {
        let polyline = GMSPolyline()
        polyline.strokeWidth = 4
        polyline.strokeColor = .oragenColor
        
        return polyline
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUI()
    }
}
