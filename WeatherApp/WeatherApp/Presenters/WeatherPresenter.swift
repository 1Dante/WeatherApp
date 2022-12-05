//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Viktor on 02.12.2022.
//

import Foundation

protocol WeatherDelegate: AnyObject {
    func reloadTableView()
    func addCity(name: String)
}

class WeatherPresenter {

    weak var delegate: WeatherDelegate?

    var weather: Weather?
    var cityName = ""
    var currentIcon = Data()
    var dailyIcons: [Data] = []
    var hourlyIcons: [Data] = []

    func fetchWeather(latitude: String, longitude: String) {
        NetworkManager.shared.fetchData(for: EndpontParameters.mainWeather(latitude: latitude, longitude: longitude)) { (result: Result<Weather,Error>) in
            switch result {
            case .success(let weather):
                self.weather = weather
                if !weather.currentWeather.weatherIcon.isEmpty {
                    self.fetchIcon(icon: weather.currentWeather.weatherIcon[0].icon, completion: { self.currentIcon = $0} )
                }
                self.mapDailyWeather(daily: weather.daily)
                self.mapHourlyWeather(hourly: weather.hourly)
                self.delegate?.reloadTableView()
            case .failure(let failure):
                print(failure)
            }
        }
        getCityName(latitude: latitude, longitude: longitude)
    }

    private func mapHourlyWeather(hourly: [Hourly]) {
        let _ = hourly.map { hour in
            if !hour.weatherIcon.isEmpty  {
                self.fetchIcon(icon: hour.weatherIcon[0].icon) { data in
                    self.hourlyIcons.append(data)
                }
            }
            if hourly.last?.date == hour.date {
                self.delegate?.reloadTableView()
            }
        }
    }

    private func mapDailyWeather(daily: [Daily]) {
        let _ = daily.map { day in
            if !day.weatherIcon.isEmpty {
                self.fetchIcon(icon: day.weatherIcon[0].icon) { data in
                    self.dailyIcons.append(data)
                }
            } else {
                self.dailyIcons.append(Data())
            }
            if daily.last?.date == day.date {
                self.delegate?.reloadTableView()
            }
        }
    }

    private func fetchIcon(icon: String, completion: @escaping (Data) -> Void) {
        NetworkManager.shared.fetchImageContent(for: EndpontParameters.iconWeather(icon: icon)) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    private func getCityName(latitude: String, longitude: String) {
        NetworkManager.shared.fetchData(for: EndpontParameters.getCityName(latitude: latitude, longitude: longitude)) { (result: Result<[CityName], Error>) in
            switch result {
            case .success(let success):
                self.delegate?.addCity(name: success.first?.localName.uk ?? "N/A")
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func setViewDelegate(delegate: WeatherDelegate) {
        self.delegate = delegate
    }
}
