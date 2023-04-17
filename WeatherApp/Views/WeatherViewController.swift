//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chirag on 4/15/23.
//

import UIKit
import MapKit

/// Home Screen for Weather App
///
class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherView: WeatherView!
    
    private let presenter = WeatherViewControllerPresenter()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var weather = [Weather]()
    let searchResultsController = SearchResultsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController:searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchResultsController.delegate = self;
        navigationItem.searchController = searchController

        presenter.delegate = self
    
        //If User has last saved Location. Retrieve that first.
        if((UserDefaults.standard.value(forKey: WeatherConstants.lastLatKey)) != nil && (UserDefaults.standard.value(forKey: WeatherConstants.lastLonKey)) != nil)
        {
            let lastLatitude = UserDefaults.standard.double(forKey: WeatherConstants.lastLatKey)
            let lastLongitude = UserDefaults.standard.double(forKey: WeatherConstants.lastLonKey)
            presenter.getWeather(latitude: lastLatitude, longitude: lastLongitude)
        }
        else
        {
            setUpCurrentLocation()
        }
    }
    
    func setUpCurrentLocation() {
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            guard let currentLocation = currentLocation else {
                return
            }
            let lat = currentLocation.coordinate.latitude
            let long = currentLocation.coordinate.longitude
            presenter.getWeather(latitude: lat, longitude: long)
        }
    }
    
    func saveToUserDefaults(loc: Coord) {
        UserDefaults.standard.set(loc.lat, forKey: WeatherConstants.lastLatKey)
        UserDefaults.standard.set(loc.lon, forKey: WeatherConstants.lastLonKey)
        UserDefaults.standard.synchronize()
    }
        
}

extension WeatherViewController : WeatherViewControllerPresenterDelegate {
    
    func updateWeather(response: WeatherData) {
            weatherView.configureView(model: response)
        saveToUserDefaults(loc: response.coord)
        
    }
    
}

extension WeatherViewController : SearchResultsDelegate {
    
    func showWeather(forLocation: Location) {
        presenter.getWeather(latitude: forLocation.lat, longitude: forLocation.lon)
    }
    
}

