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

class BKCurrentRadeViewController: BKBaseViewController {
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
    
    @IBOutlet weak var mapView: UIView! {
        didSet {
            mapView.backgroundColor = .clear
        }
    }
    
    //MARK: Variables
    internal var mapsManaget: BKMapsManager?
    internal var observation: NSKeyValueObservation?
    
    //MARK: Properties
    internal lazy var myMapView: GMSMapView = {
        let camera = GMSCameraPosition(
            latitude: -33.868,
            longitude: 151.2086,
            zoom: 14
        )
        
        return GMSMapView(frame: .zero, camera: camera)
    }()
    
    internal var location: CLLocation? {
        didSet {
            guard oldValue == nil, let firstLocation = self.location else { return }
            self.myMapView.camera = GMSCameraPosition(
                target: firstLocation.coordinate,
                zoom: self.myMapView.camera.zoom
            )
            
            self.mapsManaget?.setDefaultSearchNearStores(
                coordinate: firstLocation.coordinate,
                closure: { _ in }
            )
        }
    }
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUI()
    }
    
    public override func removeReferenceContext() {
        self.observation?.invalidate()
        
        super.removeReferenceContext()
    }
}
