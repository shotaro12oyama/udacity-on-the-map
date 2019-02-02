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
}

