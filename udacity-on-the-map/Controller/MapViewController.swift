//
//  MapViewController.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/12.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var mapView: MKMapView!
    var parse: [ParseResponse]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ParseClient.requestStudentInfoList() { parseResult, error in
            self.parse = parseResult?.results
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        }
        
        var annotations = [MKPointAnnotation]()
        for dictionary in self.parse {
            if dictionary.latitude != nil, dictionary.longitude != nil, dictionary.firstName != nil, dictionary.lastName != nil, dictionary.mediaURL != nil {
                let lat = CLLocationDegrees(dictionary.latitude!)
                let long = CLLocationDegrees(dictionary.longitude!)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = dictionary.firstName
                let last = dictionary.lastName
                let mediaURL = dictionary.mediaURL
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(String(describing: first)) \(String(describing: last))"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            

        }
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)

    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
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
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: {result in print(result)})
            }
        }
    }
    
    //    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //
    //        if control == annotationView.rightCalloutAccessoryView {
    //            let app = UIApplication.sharedApplication()
    //            app.openURL(NSURL(string: annotationView.annotation.subtitle))
    //        }
    //    }

}

