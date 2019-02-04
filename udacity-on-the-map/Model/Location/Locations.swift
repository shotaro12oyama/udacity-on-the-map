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
    static var address: String?
    static var userName: String?
    static var mediaURL: String?
    
    class func setHttpMethod (httpMethod: String) {
        self.httpMethod = httpMethod
    }
    
    class func setLocations(address: String, userName: String, mediaURL: String) {
        self.address = address
        self.userName = userName
        self.mediaURL = mediaURL
    }
    
}
