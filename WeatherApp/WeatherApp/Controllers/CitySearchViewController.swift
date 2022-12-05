//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Viktor on 04.12.2022.
//

import UIKit
import GooglePlaces

class CitySearchViewController: GMSAutocompleteViewController {

    var coordinates: ((CLLocationCoordinate2D)-> Void) = {_ in }

    override func viewDidLoad() {
        self.delegate = self
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.coordinate.rawValue))

        self.placeFields = fields
        var filter = GMSAutocompleteFilter()
        filter.types = ["locality"]
        self.autocompleteFilter = filter
    }
}

extension CitySearchViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        coordinates(place.coordinate)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
}

