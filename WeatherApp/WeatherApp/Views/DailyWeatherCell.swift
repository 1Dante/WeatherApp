//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by Viktor on 02.12.2022.
//

import UIKit

class DailyWeatherCell: UITableViewCell {

    static let reuseIdentifier = String(describing: DailyWeatherCell.self)

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()

    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.contentMode = .center
        return label
    }()

    let iconWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        let mainStack = UIStackView(arrangedSubviews: [dateLabel, temperatureLabel, iconWeatherImageView])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        mainStack.spacing = 50
        addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
}
