//
//  ViewController.swift
//  Weather_GPS_master
//
//  Created by Mac on 15/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{

    // CREATING OUTLETS FOR EACH
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // CREATING INSTANCES FOR WEATHER & LOCATION MANAGER
    var weartherManager = WeatherManager()
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
         // ASSIGNING DELEGATE FOR LOCATION MANAGER & REQUESTING LOCATION
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // ASSIGNING DELEGATE FOR WEATHER MANAGER & TEXT FIELD
        weartherManager.delegate = self
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
   
    
    
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func searchPressed(_ sender: UIButton)
       {
           searchTextField.endEditing(true)
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextField.endEditing(true)
           return true
       }
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != ""
           {
               return true
           }else
           {
               textField.placeholder = "Type Something Here"
               return false
           }
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
          if let city = searchTextField.text
          {
           weartherManager.fetchWeather(cityName: city)
           }
           searchTextField.text = ""
       }
       
}

//MARk: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
       // print(weather.temperature)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    func didFailWithError(error: Error){
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    
    
  @IBAction func locationPressed(_ sender: UIButton)
  {
           locationManager.requestLocation()
   }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
       {
           if let location = locations.last
           {
               locationManager.stopUpdatingLocation()
               let lat = location.coordinate.latitude
               let lon = location.coordinate.longitude
               weartherManager.fetchWeather(latitude: lat , longitude : lon)
               
           }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

