//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import Foundation
import CoreLocation


class WeatherPresenter {
    
    var delegate: WeatherViewDelegate?
    
    init(view: WeatherViewDelegate) {
        self.delegate = view
    }
    
    //MARK: Get weather data on coordinator
    func getWeatherData(for coordinate: CLLocationCoordinate2D) {
        WeatherService.shared.getWeatherData(requestType: .coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)) { result in
            switch result {
            case .success(let weather):
                self.delegate?.updateWeatherUI(weather: weather)
            case .failure(_):
                break
            }
        }
    }
}

