//
//  WASearchResultsPresenter.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation
import UIKit
import CoreLocation

protocol SearchResultsPresenterDelegate: AnyObject {
    // Update Weather Table with model
    func updateWithLocations(response: [Location])
}

class SearchResultsPresenter {
    
    weak var delegate : SearchResultsPresenterDelegate?
    
    public func setViewDelegate(delegate: SearchResultsPresenterDelegate){
        self.delegate = delegate
    }
    
    public func getLocations(city:String) {
        // Make Service Call
        let urlString = "\(WeatherConstants.BASE_URL)/geo/1.0/direct?q=\(city)&limit=5&appid=\(WeatherConstants.API_KEY)"
        print(urlString)
        ServiceBuilder().makeServiceCall(url: urlString) { data, response , error in
            guard let data = data, error == nil else {
                return
            }
            var json: [Location]?
            do {
                // Parse Data into Weather Object
                json = try JSONDecoder().decode([Location].self,from: data)
                
            }
            catch {
                print(error)
            }
            
            guard let result = json else {
                return
            }
            print(result)
            
            //Update View with Response
            self.delegate?.updateWithLocations(response: result)
        }
                        
    }
    
    
}
