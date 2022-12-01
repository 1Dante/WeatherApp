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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let iconWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        self.backgroundColor = .yellow
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        addSubview(iconWeatherImageView)
        addSubview(timeLabel)
    }

}
