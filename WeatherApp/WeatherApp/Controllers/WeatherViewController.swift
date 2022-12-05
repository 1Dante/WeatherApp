//
//  _WeatherViewController.swift
//  WeatherApp
//
//  Created by Viktor on 02.12.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    var tableView: UITableView!
    var collectionView: UICollectionView!
    var weatherPresenter = WeatherPresenter()
    var coordinates = Coordinates()

    override func viewDidLoad() {
        setUp()
        super.viewDidLoad()
        weatherPresenter.setViewDelegate(delegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        weatherPresenter.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude)
        if let encodedData = try? JSONEncoder().encode(coordinates) {
            UserDefaults.standard.set(encodedData, forKey: "coordinate")
        }
    }

    func setUp() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle.fill"), style: .plain, target: self, action: #selector(openMap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass.circle.fill"), style: .plain, target: self, action: #selector(openCitySearch))
        tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        self.view.addSubview(tableView)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self

        tableView.register(CurrentWeatherHeaderView.self, forHeaderFooterViewReuseIdentifier: CurrentWeatherHeaderView.reuseIdentifier)
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.reuseIdentifier)
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    @objc func openMap() {
        let googleMapViewController = GoogleMapViewController()
        self.navigationController?.pushViewController(googleMapViewController, animated: true)
        googleMapViewController.coordinates = { coordinates in
            self.coordinates = Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude)

        }
    }

    @objc func openCitySearch() {
        let citySearchViewController = CitySearchViewController()
        self.navigationController?.pushViewController(citySearchViewController, animated: true)
        citySearchViewController.coordinates = { coordinates in
            self.coordinates = Coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    }

    private func windDegreeToWindDescription(degree:Int) -> String {
        switch degree {
        case 0...33:
            return "↓"
        case 34...78:
            return "↙"
        case 79...123:
            return "←"
        case 124...168:
            return "↖"
        case 169...213:
            return "↑"
        case 214...258:
            return "↗"
        case 259...303:
            return "→"
        case 304...347:
            return "↘"
        case 348...360:
            return "↓"
        default:
            return "N/A"
        }
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        case 1: return weatherPresenter.weather?.daily.count ?? 0
        default: return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            if let dailyWeatherCell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.reuseIdentifier, for: indexPath) as? DailyWeatherCell, let weather = weatherPresenter.weather {
                dailyWeatherCell.dateLabel.text = Date.dailyDate(date: weather.daily[indexPath.row].date).uppercased()
                dailyWeatherCell.temperatureLabel.text = String(format: "%.0f", weather.daily[indexPath.row].temp.max) + "° / " + String(format: "%.0f", weather.daily[indexPath.row].temp.min) + "°"

                if indexPath.row < weatherPresenter.dailyIcons.count {
                    dailyWeatherCell.iconWeatherImageView.image = UIImage(data: weatherPresenter.dailyIcons[indexPath.row])
                }
                return dailyWeatherCell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = CurrentWeatherHeaderView()
            guard let weather =  weatherPresenter.weather else { return nil }
            headerView.dateLabel.text = Date.todayDate(date: weather.currentWeather.date)
            headerView.descriptionLabel.text = weather.currentWeather.weatherIcon.first?.description
            headerView.humidityLabel.text = String(format: "%ld", weather.currentWeather.humidity) + " %"
            headerView.pressureLabel.text = String(format: "%ld", weather.currentWeather.pressure)
            headerView.temperatureLabel.text = String(format: "%.0f", weather.currentWeather.temp) + "℃"
            headerView.windLabel.text = String(format: "%.0f", weather.currentWeather.windSpeed) + " " + windDegreeToWindDescription(degree: weather.currentWeather.windDegree)
            headerView.iconImageView.image = UIImage(data: weatherPresenter.currentIcon)
            return headerView

        } else if section == 1 {
            collectionView.backgroundColor = .hourlyWeatherColor
            return collectionView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 200
        } else if section == 1 {
            return 120
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 44
        }
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherPresenter.weather?.hourly.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath) as! HourlyWeatherCell
        if let weather = weatherPresenter.weather {
            hourlyWeatherCell.timeLabel.text = Date.hourlyDate(date: weather.hourly[indexPath.row].date) + ":00"
            hourlyWeatherCell.temperatureLabel.text = String(format: "%.0f", weather.hourly[indexPath.row].temp) + "°"
            if indexPath.row < weatherPresenter.hourlyIcons.count {
                hourlyWeatherCell.iconWeatherImageView.image = UIImage(data: weatherPresenter.hourlyIcons[indexPath.row])
            }
        }
        return hourlyWeatherCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80)
    }

}

extension WeatherViewController: WeatherDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    func addCity(name: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = name
        }
    }
}
