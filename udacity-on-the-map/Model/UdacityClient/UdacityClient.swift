//
//  UdacityClient.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/13.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//
//

import Foundation

class UdacityClient {
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case session
        case userdata
        
        var stringValue: String {
            switch self {
            case .session:
                return Endpoints.base + "/session/"
            case .userdata:
                return Endpoints.base + "/users/"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func requestLogin(username: String?, password: String?, completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"shotaro.oyama@sumitomocorp.com\", \"password\": \"ooyy1954\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)

            let decoder = JSONDecoder()
            do {
                let loginResponse = try decoder.decode(LoginResponse.self, from: newData!)
                //let session = loginResponse.session
                DispatchQueue.main.async {
                    completionHandler(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                }
            }
            
        }
        task.resume()
        

    }

}
