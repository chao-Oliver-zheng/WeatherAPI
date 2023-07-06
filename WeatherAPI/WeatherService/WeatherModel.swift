//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/25/23.
//

import Foundation


struct Location: Codable, Hashable {
    let name: String
    let country: String
    let state: String
    let lat: Double
    let lon: Double
}




struct Response: Decodable, Hashable {
    let name: String
    let timezone: Int
    let weather: [Weather]
    let main: Main
    let coord: Coord
    
}

struct Weather: Decodable, Hashable {
    let description: String
    let icon: String
}
struct Coord: Decodable, Hashable {
    let lon: Double
    let lat: Double
}
struct Main: Decodable, Hashable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

