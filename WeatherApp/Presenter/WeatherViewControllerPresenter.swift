//
//  WAViewControllerPresenter.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherViewControllerPresenterDelegate: AnyObject {
    // Update Weather Table with model
    func updateWeather(response: WeatherData)
}

class WeatherViewControllerPresenter {
    
    weak var delegate : WeatherViewControllerPresenterDelegate?
    var weatherResponse: WeatherData?
    
    public func setViewDelegate(delegate: WeatherViewControllerPresenterDelegate){
        self.delegate = delegate
    }
    
    public func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // Make Service Call
        
        let urlString = "\(WeatherConstants.BASE_URL)/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=imperial&appid=\(WeatherConstants.API_KEY)"
        
        ServiceBuilder().makeServiceCall(url: urlString) { data, response , error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                // Parse Data into Weather Object
                self.weatherResponse = try JSONDecoder().decode(WeatherData.self,from: data)
            }
            catch {
                print(error)
            }

            guard let result = self.weatherResponse else {
                return
            }
            print(result)
            //Update View with Response
            self.delegate?.updateWeather(response: result)
        }
    }
    
    
}
