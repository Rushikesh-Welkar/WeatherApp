//
//  WeatherModel.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import Foundation

public struct Weather {
    let name: String
    let temperature: String
    let description: String
    let iconName: String
    
    init(response: APIResponse) {
        self.name = response.name
        self.temperature = "\(Int(response.main.temp))"
        self.description = response.weather.first!.description
        self.iconName = response.weather.first!.iconName
    }
}

struct APIResponse: Decodable {
    var name: String
    var main: APIMain
    var weather: [APIWeather]
}

struct APIMain: Decodable {
    var temp: Double
}

struct APIWeather: Decodable {
    var description: String
    var iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
