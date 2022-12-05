//
//  CurrentWeatherHeaderView.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import UIKit

class CurrentWeatherHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = String(describing: CurrentWeatherHeaderView.self)

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    let temperatureIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "thermometer")
        imageView.contentMode = .center
        imageView.tintColor = .white
        return imageView
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    let humidityIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "humidity")
        imageView.contentMode = .center
        imageView.tintColor = .white
        return imageView
    }()

    let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    let pressureIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.down.to.line.compact")
        imageView.contentMode = .center
        imageView.tintColor = .white
        return imageView
    }()

    let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wind")
        imageView.contentMode = .center
        imageView.tintColor = .white
        return imageView
    }()

    let windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        let backgroundView = UIView(frame: self.bounds)
        backgroundView.backgroundColor = .headerColor
        self.backgroundView = backgroundView

        let iconsStack = UIStackView(arrangedSubviews: [temperatureIconImageView, humidityIconImageView, pressureIconImageView, windImageView])
        iconsStack.axis = .vertical
        iconsStack.distribution = .fillEqually
        iconsStack.spacing = 7
        let labelStack = UIStackView(arrangedSubviews: [temperatureLabel, humidityLabel, pressureLabel, windLabel])
        labelStack.axis = .vertical
        labelStack.distribution = .fillEqually
        labelStack.spacing = 5
        let informationStack = UIStackView(arrangedSubviews: [iconsStack, labelStack])
        informationStack.axis = .horizontal
        informationStack.distribution = .fillProportionally
        informationStack.spacing = 10
        let fullStack = UIStackView(arrangedSubviews: [descriptionLabel, informationStack])
        fullStack.axis = .vertical
        fullStack.distribution = .fill
        fullStack.spacing = 10
        
        let mainStack = UIStackView(arrangedSubviews: [iconImageView, fullStack])
        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        mainStack.spacing = 10
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStack)
        addSubview(dateLabel)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
