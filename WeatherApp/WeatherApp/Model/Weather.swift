//
//  Weather.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

struct Weather: Codable {
    let currentWeather: CurrentWeather
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case currentWeather = "current"
        case hourly
        case daily
    }
}

struct CurrentWeather: Codable {
    let date: Date
    let temp: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let windDegree: Int
    let weatherIcon: [WeatherIcon]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case pressure
        case humidity
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case weatherIcon = "weather"
    }
}

struct Hourly: Codable {
    let date: Date
    let temp: Double
    let weatherIcon: [WeatherIcon]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weatherIcon = "weather"
    }
}

struct Daily: Codable {
    let date: Date
    let temp: Temp
    let weatherIcon: [WeatherIcon]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case weatherIcon = "weather"
    }
}

struct Temp: Codable {
    let min: Double
    let max: Double
}


struct WeatherIcon: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}



