//
//  Coordinates.swift
//  WeatherApp
//
//  Created by Viktor on 05.12.2022.
//

import Foundation

struct Coordinates: Codable {

    var latitude = ""
    var longitude = ""

    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = String(format: "%.2f", latitude)
        self.longitude = String(format: "%.2f", longitude)
    }
}
