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
    
    internal lazy var mutablePath = GMSMutablePath()
    
    //MARK: Properties
    internal var rideViewModel: BKRideViewModelProtocol? {
        return self.viewModel as? BKRideViewModelProtocol
    }
    
    internal lazy var myMapView: GMSMapView = {
        let camera = GMSCameraPosition(
            latitude: -33.868,
            longitude: 151.2086,
            zoom: 17
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
                closure: { address in
                    self.rideViewModel?.startAddressLiveData.value = address
                }
            )
        }
    }
    
    internal var trackLocation: CLLocation? {
        didSet {
            guard let firstLocation = self.trackLocation else { return }
            
            if oldValue != nil && (oldValue!.coordinate.latitude == firstLocation.coordinate.latitude && oldValue!.coordinate.longitude == firstLocation.coordinate.longitude) {
                return
            }
            
            self.rideViewModel?.coordinateLiveData.value = firstLocation.coordinate
        }
    }
    
    internal lazy var yourTimeWasView: BKYourTimeWasView = {
        let view = BKYourTimeWasView()
        view.delegate = self
        return view
    }()
    
    internal lazy var simplePopUpView: BKSimplePopUpView = {
        let view = BKSimplePopUpView()
        view.delegate = self
        return view
    }()
    
    internal lazy var polyline: GMSPolyline = {
        let polyline = GMSPolyline()
        polyline.strokeWidth = 4
        polyline.strokeColor = .oragenColor
        
        return polyline
    }()
    
    internal var timerView: BKTimerView?
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupBinds()
        self.updateUI()
    }
    
    //MARK: Functions
    override func rightNavButtonSelector() {
        self.setupTimerView()
    }
    
    public override func removeReferenceContext() {
        self.observation?.invalidate()
        
        super.removeReferenceContext()
    }
}
