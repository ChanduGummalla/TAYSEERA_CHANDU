//
//  APICall.swift
//  APICall
//
//  Created by HTS on 20/10/22.
//

import Foundation
import UIKit
class APIHandler {
    
    let header: [String: String] = [
        "Content-Type": "application/json",
    ]
    
    func getCallAPI(urlString: String, completion handler: @escaping(_ response: Any) -> Void) {
        let configuration = URLSessionConfiguration.default
        let urlsession = URLSession(configuration: configuration)
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.allHTTPHeaderFields = header
        let dataTask = urlsession.dataTask(with: urlRequest) { data, response, error in
            if let data = data  {
                handler(data)
//                do {
//                    let jsonDecoder = JSONDecoder()
//                    let emplData = try? jsonDecoder.decode(countrym.self, from: data )
//                    print(emplData?.data[0].employee_name)
//                    self.finalData = emplData?.data
//                } catch {
//
//                }
//            } else {
//                print("There is not data to display")
            }
        }
        dataTask.resume()
    }
    
    
    func postAPICall(paramters: [String: Any], urlString: String, completion handler: @escaping(_ response: Any) -> Void ) {
        let configuration = URLSessionConfiguration.default
        let urlsession = URLSession(configuration: configuration)
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            print(paramters)
            urlRequest.allHTTPHeaderFields = header
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: paramters, options: .prettyPrinted)
         } catch let error {
            print(error.localizedDescription)
            return
          }
        
        let dataTask = urlsession.dataTask(with: urlRequest) { data, response, error in
            if let data = data  {
              handler(data)
            } else {
                print("There is not data to display")
            }
        }
        dataTask.resume()
    }
 
}


