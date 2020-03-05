//
//  CheckDangerLocationViewController.swift
//  COVID19
//
//  Created by 전해동 on 2020/03/01.
//  Copyright © 2020 전해동. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CheckDangerLocationViewController: CustomViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView:MKMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        Location.location.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = .follow
        myLocation(latitude: Location.location.CLLocation?.coordinate.latitude ?? 0, longitude: Location.location.CLLocation?.coordinate.longitude ?? 0, delta: 0.01)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func myLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta: Double){
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta,longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        print("\(latitude) , \(longitude)")
        mapView?.setRegion(locationRegion, animated: true)
    }
    
}
