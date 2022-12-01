//
//  ViewController.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import UIKit

class WeatherViewController: UIViewController {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
       // collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        setUp()
        super.viewDidLoad()
        }

    func setUp() {

         // let layaut = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
       // layaut.headerReferenceSize = CGSize(width: 200, height: 200)
      //  collectionView.setCollectionViewLayout(layaut, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .cyan
        self.view.addSubview(collectionView)
        collectionView.register(CurrentWeatherHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CurrentWeatherHeaderView.reuseIdentifier)
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.reuseIdentifier)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8)

        ])
    }

}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0: return 5
//        case 1: return 1
//        default: return 1
//        }
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath)
        return hourlyWeatherCell
    }


    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentWeatherHeaderView.reuseIdentifier, for: indexPath)
           
            return headerView
        default: fatalError("Unexpected element kind")
        }
    }

   @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            return CGSize(width: collectionView.frame.width, height: 200)

    }


}

