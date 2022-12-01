//
//  Weather.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main?
    let wind: Wind?
    let coord: Coord
}

struct Weather: Codable {
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double?
    let feels_like: Double?
    let pressure: Int?
    let humidity: Int?
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
