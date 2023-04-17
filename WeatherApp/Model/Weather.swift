//
//  Weather.swift
//  WeatherApp
//
//  Created by Chirag on 4/16/23.
//

import Foundation

struct WeatherData: Codable {
    let coord: Coord
    let name: String
    let id: Int
    let timezone: Int
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

struct Weather: Codable {
    
    enum CodingKeys: String, CodingKey {
        case descriptionKey = "description"
        case id
        case main
        case icon
    }
    let id: Int
    let main: String
    let descriptionKey: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double

}
struct Wind: Codable {
    let speed: Double
}

struct Clouds: Codable {
    let all: Double
}

struct Rain: Codable {
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHours = "3h"
    }
    let oneHour: Double
    let threeHours: Double
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}


