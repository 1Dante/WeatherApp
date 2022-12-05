//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    static var reuseIdentifier = String(describing: HourlyWeatherCell.self)
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let iconWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
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
        backgroundColor = .hourlyWeatherColor
        let mainStack = UIStackView(arrangedSubviews: [timeLabel, iconWeatherImageView, temperatureLabel])
        mainStack.spacing = 2
        mainStack.axis = .vertical
        mainStack.alignment = .center
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        ])
    }
    
}
