//
//  DetailsViewController.swift
//  Weather App
//
//  Created by Rushikesh on 30/10/23.
//

import UIKit

protocol WeatherDetailsViewDelegate {
    func updateWeatherDetailsUI(weather: Weather)
    func handleError(errorMessage: String)
}

class WeatherDetailsViewController: UIViewController {
   
    //MARK: Outlet for ui component
    @IBOutlet private weak var cityNameTxtField: UITextField!
    @IBOutlet private weak var getDetailsButton: UIButton!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    private var activityIndicator = UIActivityIndicatorView()
    private var presenter: WeatherDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = WeatherDetailsPresenter(view: self)
        self.presenter?.delegate = self
        
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.color = .blue
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tempLabel.isHidden = true
        self.descriptionLabel.isHidden = true
        self.nameLabel.isHidden = true
    }
    
    //MARK: get details of city action button
    @IBAction func getDetailsAction(_ sender: Any) {
        guard let city = cityNameTxtField.text else { return }
        self.cityNameTxtField.resignFirstResponder()
        activityIndicator.startAnimating()
        presenter?.getWeatherData(for: city)
    }
    
    //MARK: close button
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WeatherDetailsViewController: WeatherDetailsViewDelegate {
    //MARK: Handle Error message
    func handleError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateWeatherDetailsUI(weather: Weather) {
        //MARK: update the ui on response
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tempLabel.isHidden = weather.temperature.isEmpty
            self.descriptionLabel.isHidden = weather.description.isEmpty
            self.nameLabel.isHidden = weather.name.isEmpty
            self.tempLabel.text = "\(weather.temperature)°"
            self.descriptionLabel.text = weather.description
            self.nameLabel.text = weather.name
        }
    }
}
