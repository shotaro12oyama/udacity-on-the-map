//
//  Locations.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/25.
//  Copyright © 2019 尾山昌太郎. All rights reserved.
//

import Foundation
import CoreLocation

class Locations {
    static var httpMethod: String = "POST"
    static var address: String = "Tokyo"
    static var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 135.0, longitude: 35.0)
    static var userName: String = "nick name"
    static var mediaURL: String = "http://google.com"
    
    class func setLocations(method: String, address: String, nickName: String, mediaURL: String) {
        self.httpMethod = method
        self.address = address
        self.location = getCoordinate(address: address)
        self.userName = nickName
        self.mediaURL = mediaURL
    }
    
    class func getCoordinate(address: String) -> CLLocationCoordinate2D  {
        var lat: Double = 135.0
        var lng: Double = 35.0
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            if error != nil {
                print(error!)
            }
            lat = placemarks?.first?.location?.coordinate.latitude ?? 135.0
            lng = placemarks?.first?.location?.coordinate.longitude ?? 35.0
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
}
