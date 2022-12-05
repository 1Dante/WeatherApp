//
//  Extentions+Date.swift
//  WeatherApp
//
//  Created by Viktor on 03.12.2022.
//

import Foundation

extension Date {

    static func todayDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        return formatter.string(from: date)
    }

    static func hourlyDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: date)
    }

    static func dailyDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}
