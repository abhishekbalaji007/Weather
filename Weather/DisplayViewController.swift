//
//  DisplayViewController.swift
//  Weather
//
//  Created by BALAJI ABHISHEK on 2/17/19.
//  Copyright © 2019 BALAJI ABHISHEK. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON




// This class contains methods for getting the weather data, parsing data and displaying results on user interface.


class DisplayViewController: UIViewController, CLLocationManagerDelegate, SearchCityDelegate , SettingsDelegate {
    

    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "48c174e4b2812ac8ec7d31cb0253d6a1"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
        
    }
  
    
    func changeColor(color: UIColor) {
        self.view.backgroundColor = color
    }

    // This Method gets the weather data using the location details.
    
    func getWeatherData(appUrl:String,parameters:[String:String]) {
        
        Alamofire.request(appUrl, method: .get, parameters: parameters) . responseJSON {
            response in
            if response.result.isSuccess {
                let result:JSON = JSON(response.result.value!)
                self.parseJson(data: result)
            }
            else {
                print("failure")
            }
        }
        
    }
    
    
    //   This method is for JSON Parsing.
   
    
    func parseJson(data:JSON){
        
        if let temp = data["main"]["temp"].double {
            
            weatherDataModel.temperatureInCentigrade = Int(temp - 273.15)
            weatherDataModel.temperatureInFahrenheit = Int(temp * 9/5 - 459.67)
            let name = data["name"].stringValue
            weatherDataModel.city = name
            let weather = data["weather"][0]["id"]
            weatherDataModel.condition = weather.intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherDataInCentigrade()
            updateUIWithWeatherDataInFahrenheit()
            
        }
            
        else {
            print("unavaila")
            cityLabel.text = "Location Unavailable"
        }
        
    }
    
    
    
    //This method is for UI updates in fahrenheit temperature.
    
    func updateUIWithWeatherDataInFahrenheit() {
        
        temperatureLabel.text = "\(weatherDataModel.temperatureInFahrenheit)°"
        print("\(String(weatherDataModel.temperatureInFahrenheit)) \(weatherDataModel.city) \(weatherDataModel.condition) ")
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
     //This method is for UI updates in centigrade temperature.
    
    
    func updateUIWithWeatherDataInCentigrade() {
        
        temperatureLabel.text = "\(weatherDataModel.temperatureInCentigrade)°"
        print("\(String(weatherDataModel.temperatureInCentigrade)) \(weatherDataModel.city) \(weatherDataModel.condition) ")
        cityLabel.text = weatherDataModel.city
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    //This method gets the current location details.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
        }
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let details : [String : String] = ["lat" : latitude , "lon" : longitude , "appid" : APP_ID]
        
        getWeatherData (appUrl : WEATHER_URL, parameters: details)
        
        
    }
    
    
    //This method executes when location is unavailable.
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    //This method is used to get the weather data based on city name.
    
    func cityNameEntered(city: String) {
        
        let params : [String:String] = ["q":city,"appid":APP_ID]
        getWeatherData(appUrl: WEATHER_URL, parameters: params)
    }
    

    // This method sets the delegate of SearchCityDelegate protocol and Settings Delegate protocol to current class.
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destination = segue.destination as! SearchCityViewController
            
           destination.cityChangedDelegate = self
        }
        else if segue.identifier == "settings" {
            let settingsDestination = segue.destination as! SettingsViewController
            settingsDestination.changeColourDelegate = self
            settingsDestination.temperatureDelegate  = self
        }
        
    }
  
    
    
    

}
