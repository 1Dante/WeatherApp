//
//  EndpointParameters.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

enum EndpontParameters: Endpoint {
    case currentWeather
    case hourlyWeather
    case dailyWeather

    private var apiKey: String {
        return "01a029174fbc918bcd68b6d5dc80dbea"
    }

    func queryItem(latitude: String, longitude: String) -> [URLQueryItem] {
        var queryItem: [URLQueryItem] =
                                [URLQueryItem(name: "appid", value: apiKey),
                              URLQueryItem(name: "lang", value: "ua"),
                                 URLQueryItem(name: "lat", value: latitude),
                                URLQueryItem(name: "lon", value: longitude)]
        switch self {
        case .currentWeather:
            queryItem.append(URLQueryItem(name: "exclude", value: "current"))
        case .hourlyWeather:
            queryItem.append(URLQueryItem(name: "exclude", value: "hourly"))
        case .dailyWeather:
            queryItem.append(URLQueryItem(name: "exclude", value: "daily"))
        }
        return queryItem
    }
}
