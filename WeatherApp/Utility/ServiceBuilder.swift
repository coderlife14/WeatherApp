//
//  ServiceBuilder.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation

class ServiceBuilder {

    func makeServiceCall(url:String, completionHandler:@escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response , error in
            
            guard let data = data, error == nil else {
                return
            }
            
            completionHandler(data,response,error)
            
        }).resume()
    
    }
}
