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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = Locations.location
        annotation.title = Locations.userName
        annotation.subtitle = Locations.mediaURL
        print(Locations.userName)
        print(Locations.mediaURL)
        print(Locations.location)
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
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

    }
    

}

