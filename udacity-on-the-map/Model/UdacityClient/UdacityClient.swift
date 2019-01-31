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
    
    struct Auth {
        static var username: String?
        static var key = ""
    }
    
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
        let userInfo = UserInfo(username: username, password: password)
        let body = LoginInfo(udacity: userInfo)
        request.httpBody = try! JSONEncoder().encode(body)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(String(data: newData!, encoding: .utf8)!)

            let decoder = JSONDecoder()
            do {
                let loginResponse = try decoder.decode(LoginResponse.self, from: newData!)
                Auth.username = username
                Auth.key = loginResponse.account.key
                
                DispatchQueue.main.async {
                    completionHandler(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(false, error)
                }
            }
            
        }
        task.resume()
    }
    
    
    class func getSessionInfo(completion: @escaping (Bool, Error?) -> Void) {
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/" + Auth.key)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
    class func requestLogOut(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
