//
//  CurrentWeatherHeaderView.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import UIKit

class CurrentWeatherHeaderView: UICollectionReusableView {

    static let reuseIdentifier = String(describing: CurrentWeatherHeaderView.self)

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
       // imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let temperatureIconImageView: UIImageView = {
        let imagwView = UIImageView()
        imagwView.image = UIImage(systemName: "thermometer.medium")
        return imagwView
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let humidityIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "humidity")
        return imageView
    }()

    let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let pressureIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.down.to.line.compact")
        return imageView
    }()

    let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wind")
        return imageView
    }()

    let windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
      //  label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        dateLabel.text = "Today"
        descriptionLabel.text = "description"
        windLabel.text = "wind"
        pressureLabel.text = "preesss"
        humidityLabel.text = "humadity"
        temperatureLabel.text = "temperature"
        self.backgroundColor = .headerColor
        let temperatureStack = UIStackView(arrangedSubviews: [temperatureIconImageView, temperatureLabel])
        temperatureStack.axis = .horizontal
        temperatureStack.distribution = .fill
        temperatureStack.spacing = 5
        let humidityStack = UIStackView(arrangedSubviews: [humidityIconImageView, humidityLabel])
        humidityStack.axis = .horizontal
        humidityStack.distribution = .fill
        humidityStack.spacing = 5
        let pressureStack = UIStackView(arrangedSubviews: [pressureIconImageView, pressureLabel])
        pressureStack.axis = .horizontal
        pressureStack.distribution = .fill
        pressureStack.spacing = 5
        let windStack = UIStackView(arrangedSubviews: [windImageView, windLabel])
        windStack.axis = .horizontal
        windStack.distribution = .fill
        windStack.spacing = 5
        let informationStack = UIStackView(arrangedSubviews: [descriptionLabel, temperatureStack, humidityStack, pressureStack, windStack])
        informationStack.axis = .vertical
        informationStack.distribution = .fill
        informationStack.spacing = 2

        let mainStack = UIStackView(arrangedSubviews: [iconImageView, informationStack])
        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        mainStack.spacing = 10

        addSubview(mainStack)
        addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }




}
