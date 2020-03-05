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
import RxSwift

class CheckDangerLocationViewController: CustomViewController,MKMapViewDelegate {
    let patientVist = Observable<(Double,Double)>.from(Constant.patientVisit)
    @IBOutlet weak var mapView:MKMapView?
    @IBOutlet weak var dangerLabel:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Location.location.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView?.showsUserLocation = true
        mapView?.userTrackingMode = .follow
        myLocation(latitude: Location.location.CLLocation?.coordinate.latitude ?? 0, longitude: Location.location.CLLocation?.coordinate.longitude ?? 0, delta: 0.01)
        check()
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
    func check(){
        patientVist
            .filter{pos in (Location.location.CLLocation?.distance(from: CLLocation(latitude: pos.0, longitude: pos.1)) ?? 9999)<Double(1000)}
            .subscribe(onNext:{_ in self.dangerLabel?.text = "반경 1km내에 위험지역이 있습니다."; self.dangerLabel?.backgroundColor = UIColor.red})
            .dispose()
    }
}
