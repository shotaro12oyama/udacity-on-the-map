//
//  ParseClient.swift
//  udacity-on-the-map
//
//  Created by 尾山昌太郎 on 2019/01/24.
//  Copyright © 2019年 尾山昌太郎. All rights reserved.
//

import Foundation

class ParseClient {
    
    static var parse: [ParseResponse]! = []
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes/StudentLocation"
        
    }
    
    enum registerStatus {
        case registered
        case unregistered
    }

    class func requestStudentInfoList(completionHandler: @escaping ([ParseResponse], Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        //limit and sort the list
        let params = ["limit": 100, "order": "-updatedAt"] as [String : Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            completionHandler([], error)
            return
        }
        //execute POST request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            //print(String(data: data!, encoding: .utf8)!)
            let decoder = JSONDecoder()
            do {
                let parse = try decoder.decode(ParseResults.self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(parse.results, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler([], error)
                }
            }
        }
        task.resume()
    }
    
    class func getStudentLocationInfo (key: String, completionHandler: @escaping (registerStatus?, Error?) -> Void) {
    
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(key)%22%7D"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
                completionHandler(nil, error)
            }
            let decoder = JSONDecoder()
            do {
                let parse_target = try decoder.decode(ParseResults.self, from: data!)
                if parse_target.results.count != 0 {
                    DispatchQueue.main.async {
                        completionHandler(registerStatus.registered, nil)
                    }
                } else {
                    completionHandler(registerStatus.unregistered, error)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    /*
    class func addStudentLocationInfo (key: String, completionHandler: @escaping (ParseResponse?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
        
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(key)%22%7D"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let params = ["order": "-updatedAt"] as [String : Any]
        do {
            let json = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            completionHandler(nil, error)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
                completionHandler(nil, error)
            }
            let decoder = JSONDecoder()
            do {
                let parse_target = try decoder.decode(ParseResults.self, from: data!)
                if parse_target.results.count != 0 {
                    DispatchQueue.main.async {
                        completionHandler(parse_target.results[0], nil)
                    }
                } else {
                    completionHandler(nil, error)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    }
    
    class func putStudentLocationInfo (key: String, completionHandler: @escaping (ParseResponse?, Error?) -> Void) {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }*/
    
    
}

