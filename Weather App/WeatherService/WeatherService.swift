//
//  WeatherService.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    private let apiKey = "4df9fd714ca1f77ef8b2b7b6cc375840"

    enum WeatherRequestType {
        case coordinates(latitude: Double, longitude: Double)
        case city(name: String)
    }
    
    func getWeatherData(requestType: WeatherRequestType, completion: @escaping (Result<Weather, Error>) -> Void) {
        let endpoint: String
        switch requestType {
        case .coordinates(let latitude, let longitude):
            endpoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        case .city(let name):
            // You might want to URL encode the city name
            if let encodedCityName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                endpoint = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCityName)&appid=\(apiKey)&units=metric"
            } else {
                completion(.failure(NSError(domain: "WeatherService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to encode city name"])))
                return
            }
        }
        guard let endPoint  = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: endPoint) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { return }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(Weather(response: result)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


