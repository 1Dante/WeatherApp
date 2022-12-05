//
//  Endpoint.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation
protocol Endpoint {
    var baseURL: BaseURL { get }
    var path: String { get }
    var queryItem: [URLQueryItem] { get }
}

extension Endpoint {
    var baseURL: BaseURL {
        return .weatherURL
    }
    
    var path: String {
        return "/data/3.0/onecall"
    }
    
    var queryItem: [URLQueryItem] {
        return []
    }
}

enum BaseURL: String {
    case weatherURL = "https://api.openweathermap.org"
    case iconURL = "http://openweathermap.org"
}
