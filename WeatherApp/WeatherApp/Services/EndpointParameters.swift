//
//  EndpointParameters.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

enum EndpontParameters: Endpoint {

    case mainWeather(latitude: String,longitude: String)
    case iconWeather(icon: String)
    case getCityName(latitude: String,longitude: String)

    private var apiKey: String {
        return "01a029174fbc918bcd68b6d5dc80dbea"
    }

    var baseURL: BaseURL {
        switch self {
        case .mainWeather , .getCityName:
            return .weatherURL
        case .iconWeather:
            return .iconURL
        }
    }

    var path: String {
        switch self {
        case .mainWeather:
            return "/data/3.0/onecall"
        case .iconWeather(let icon):
            return "/img/wn/" + icon + "@2x.png"
        case .getCityName:
            return "/geo/1.0/reverse"
        }
    }

    var queryItem: [URLQueryItem] {
        switch self {
        case .mainWeather(let latitude, let longitude):
            let queryItem: [URLQueryItem] =
            [URLQueryItem(name: "appid", value: apiKey),
             URLQueryItem(name: "lang", value: "ua"),
             URLQueryItem(name: "lat", value: latitude),
             URLQueryItem(name: "lon", value: longitude),
             URLQueryItem(name: "units", value: "metric")]
            return queryItem
        case .iconWeather:
            return []
        case .getCityName(let latitude, let longitude):
            let queryItem: [URLQueryItem] =
            [URLQueryItem(name: "appid", value: apiKey),
             URLQueryItem(name: "lat", value: latitude),
             URLQueryItem(name: "lon", value: longitude)]
            return queryItem
        }
    }
}
