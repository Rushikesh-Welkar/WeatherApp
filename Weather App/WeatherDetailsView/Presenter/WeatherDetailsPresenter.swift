//
//  WeatherDetailsPresenter.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import Foundation
import CoreLocation


class WeatherDetailsPresenter {
    
    var delegate: WeatherDetailsViewDelegate?
    
    init(view: WeatherDetailsViewDelegate) {
        self.delegate = view
    }
    
    //MARK: Get weather data on city name
    func getWeatherData(for city: String) {
        WeatherService.shared.getWeatherData(requestType:.city(name: city)) { result in
            switch result {
            case .success(let weather):
                self.delegate?.updateWeatherDetailsUI(weather: weather)
            case .failure(_):
                self.delegate?.handleError(errorMessage: "Please enter the valid city name")
            }
        }
    }
}
