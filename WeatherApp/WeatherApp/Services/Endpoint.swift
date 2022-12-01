//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItem: [URLQueryItem] { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.openweathermap.org"
    }

    var path: String {
        return "/data/3.0/onecall"
    }

    var queryItem: [URLQueryItem] {
        return []
    }
}
