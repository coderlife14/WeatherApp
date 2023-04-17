//
//  Location.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation

struct WeatherLocations: Codable {
    let locations: [Location]
}

struct Location: Codable {
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
}
