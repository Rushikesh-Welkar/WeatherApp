//
//  ViewController.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import UIKit
import CoreLocation

protocol WeatherViewDelegate {
    func updateWeatherUI(weather: Weather)
}

class WeatherViewController: UIViewController {
    
    //MARK: Outlet for the UI component
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    private let activityIndicator = UIActivityIndicatorView()
    
    private let locationManager = CLLocationManager()
    private var presenter: WeatherPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        presenter = WeatherPresenter(view: self)
        presenter?.delegate = self
        
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = .blue
        view.addSubview(activityIndicator)
    }
    
    //MARK: navigate to weather details page
    @IBAction func nextButtonAction(_ sender: Any) {
        let detailsVC = WeatherDetailsViewController()
        _ = WeatherDetailsPresenter(view: detailsVC)
        self.present(detailsVC, animated: true, completion: nil)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    //MARK: Change Authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
  
    //MARK: taking the current location latitude and longitude
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            activityIndicator.startAnimating()
            presenter?.getWeatherData(for: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Location error: \(error.localizedDescription)")
    }
}

extension WeatherViewController: WeatherViewDelegate {
    //MARK: update the ui on response
    func updateWeatherUI(weather: Weather) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tempLabel.text = "\(weather.temperature)°"
            self.descriptionLabel.text = weather.description
            self.nameLabel.text = weather.name
        }
    }
}



