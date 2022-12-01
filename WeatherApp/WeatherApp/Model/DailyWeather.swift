//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

struct DailyWeather: Codable {
    let daily: [Daily]?
}

struct Daily: Codable {
    let temp: Temp?
    let dt: Int
    let weather: [WeatherDaily]
}

struct Temp: Codable {
    let min: Double?
    let max: Double?
}
struct WeatherDaily: Codable {
    let icon: String?
}
