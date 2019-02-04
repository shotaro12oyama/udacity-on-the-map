//
//  FinishViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/02/02.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FinishViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishButton: UIButton!

    var lat: Double?
    var lng: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(Locations.address!) { placemarks, error in
            if error != nil {
                print(error!)
            }
            self.lat = placemarks?.first?.location?.coordinate.latitude
            self.lng = placemarks?.first?.location?.coordinate.longitude
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!) as CLLocationCoordinate2D
        }
       
        annotation.title = Locations.userName!
        annotation.subtitle = Locations.mediaURL!
        //print(Locations.location!)
        self.mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    

    @IBAction func touchFinishButton(_ sender: Any) {
        ParseClient.addStudentLocationInfo(httpMethod: Locations.httpMethod, firstName: UdacityClient.PublicInfo.firstName!, lastName: UdacityClient.PublicInfo.lastName!, mapString: Locations.address!, mediaURL: Locations.mediaURL!, latitude: lat!, longitude: lng!, completionHandler: finishButtonHandler(success:error:))
        
        
    }
    
    func finishButtonHandler (success: Bool, error: Error?) {
        if success {
            print("success")
        } else {
            print(error!)
        }
    }

}

