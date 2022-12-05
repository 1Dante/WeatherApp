//
//  CityName.swift
//  WeatherApp
//
//  Created by Viktor on 04.12.2022.
//

import Foundation

struct CityName: Codable {
    let name: String
    let localName: LocalName
    
    enum CodingKeys: String, CodingKey {
        case localName = "local_names"
        case name
    }
}

struct LocalName: Codable {
    let uk: String
}
